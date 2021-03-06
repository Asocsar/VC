clear
close all
clc

NBINS = 40;

fid = fopen('Recortadas.txt');
tline = fgetl(fid);
paths = {};
i = 1;
while ischar(tline)
    if ischar(tline)
        paths{i} = tline;
        i = i + 1;
    end
    tline = fgetl(fid);
end
fclose(fid);

num_paths = length(paths);
HRL = [];
HGL = [];
HBL = [];
Hists = {};

Label_teams = {};
Label_teams{1} = 'barcelona'; 
Label_teams{2} = 'chelsea';
Label_teams{3} = 'juventus';
Label_teams{4} = 'liverpool';
Label_teams{5} = 'madrid';
Label_teams{6} = 'milan';
Label_teams{7} = 'psv';
crops = {};

meanN = 0;
meanM = 0;
Labels = zeros(1, num_paths);

Hists = zeros(num_paths,3*NBINS);
Hists_barcelona = zeros(5,3*NBINS);
index_barcelona = 1;
Hists_chelsea = zeros(5,3*NBINS);
index_chelsea = 1;
Hists_juventus = zeros(5,3*NBINS);
index_juventus = 1;
Hists_liverpool = zeros(5,3*NBINS);
index_liverpool = 1;
Hists_madrid = zeros(5,3*NBINS);
index_madrid = 1;
Hists_milan = zeros(5,3*NBINS);
index_milan = 1;
Hists_psv = zeros(5,3*NBINS);
index_psv = 1;

for i = 1:num_paths
    A = rgb2hsv(imread(paths{i}));
    crops{i} = A;
    [nC, mC] = size(A(:,:,1));
    meanN = meanN + nC;
    meanM = meanM + mC;
    
    [countsR, bins] = imhist(A(:,:,1), NBINS);
    [countsG, bins] = imhist(A(:,:,2), NBINS);
    [countsB, bins] = imhist(A(:,:,3), NBINS);
    
    
    if contains(paths{i}, 'barcelona')
        Labels(i) = 1;
        Hists_barcelona(index_barcelona,:) = HistNorm([countsR' countsG' countsB']')';
        index_barcelona = index_barcelona + 1;
    elseif contains(paths{i}, 'chelsea')
        Labels(i) = 2;
        Hists_chelsea(index_chelsea,:) = HistNorm([countsR' countsG' countsB']')';
        index_chelsea = index_chelsea + 1;
    elseif contains(paths{i}, 'juventus')
        Labels(i) = 3;
        Hists_juventus(index_juventus,:) = HistNorm([countsR' countsG' countsB']')';
        index_juventus = index_juventus + 1;
    elseif contains(paths{i}, 'liverpool')
        Labels(i) = 4;
        Hists_liverpool(index_liverpool,:) = HistNorm([countsR' countsG' countsB']')';
        index_liverpool = index_liverpool + 1;
    elseif contains(paths{i}, 'madrid')
        Labels(i) = 5;
        Hists_madrid(index_madrid,:) = HistNorm([countsR' countsG' countsB']')';
        index_madrid = index_madrid + 1;
    elseif contains(paths{i}, 'milan')
        Labels(i) = 6;
        Hists_milan(index_milan,:) = HistNorm([countsR' countsG' countsB']')';
        index_milan = index_milan + 1;
    elseif contains(paths{i}, 'psv')
        Labels(i) = 7;
        Hists_psv(index_psv,:) = HistNorm([countsR' countsG' countsB']')';
        index_psv = index_psv + 1;
    end
    

    Hists(i,:) = HistNorm([countsR' countsG' countsB']')';
    
    
   
    
end

Labels_barcelona = nonzeros(int8(Labels == 1));
Labels_chelsea = nonzeros(int8(Labels == 2));
Labels_juventus = nonzeros(int8(Labels == 3));
Labels_liverpool = nonzeros(int8(Labels == 4));
Labels_madrid = nonzeros(int8(Labels == 5));
Labels_milan = nonzeros(int8(Labels == 6));
Labels_psv = nonzeros(int8(Labels == 7));

Tree = TreeBagger(100, Hists, Labels');


meanN = meanN/num_paths;
meanM = meanM/num_paths;



% READ ALL PATH IMAGES
fid = fopen('All_images.txt');
tline = fgetl(fid);
paths = {};
i = 1;
while ischar(tline)
    if ischar(tline)
        paths{i} = tline;
        i = i + 1;
    end
    tline = fgetl(fid);
end
fclose(fid);

num_paths = length(paths);


% COMPUTE SLIDING WINDOW HIST FOR ALL IMAGES AND CLASSIFIYING
m = fix(meanM/2);
n = fix(meanN/2);



correct = 0;
Y_pred = [];
Y_true = [];
for i = 1:num_paths
    I = rgb2hsv(imread(paths{i}));
    [r c] = size(I(:,:,1));
    
    
    saltos_c = 8;
    saltos_r = 8;
    cs = fix(c/saltos_c);
    rs = fix(r/saltos_r);
    R = 0;
    score_imagen = 0;
    label_imagen = "";
    for k1 = 3:cs:c-3
        for k2 = 3:rs:r-3
            c_end = min(k1+cs, c);
            r_end = min(k2+rs, r);
            k1_start = max(k1, 1);
            k2_start = max(k2, 1);
            M = I(k2_start:r_end, k1_start:c_end, :);
            %imshow(M);
            [R, bins] = imhist(M(:,:,1), NBINS);
            [G, bins] = imhist(M(:,:,2), NBINS);
            [B, bins] = imhist(M(:,:,3), NBINS);
            X = HistNorm([R' G' B']')';
            [label, score] = predict(Tree,X);
            if score_imagen < max(score)
                score_imagen = max(score);
                label_imagen = label{1};
            end
        end
    end
    
    disp(paths{i});
    disp(Label_teams{str2num(label_imagen)});
    disp(score_imagen);
    if contains(paths{i},Label_teams{str2num(label_imagen)})
        correct = correct + 1;
    end
    Y_pred = [Y_pred I];
    if contains(paths{i}, 'barcelona')
        Y_true = [Y_true 1];
    elseif contains(paths{i}, 'chelsea')
        Y_true = [Y_true 2];
    elseif contains(paths{i}, 'juventus')
        Y_true = [Y_true 3];
    elseif contains(paths{i}, 'liverpool')
        Y_true = [Y_true 4];
    elseif contains(paths{i}, 'madrid')
        Y_true = [Y_true 5];
    elseif contains(paths{i}, 'milan')
        Y_true = [Y_true 6];
    elseif contains(paths{i}, 'psv')
        Y_true = [Y_true 7];
    end

end
confusionchart(int8(Y_true), int8(Y_pred),'RowSummary','row-normalized','ColumnSummary','column-normalized');
correct = correct/num_paths;
disp(["Accuracy of", correct*100, "%"]);