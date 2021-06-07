clear
close all
clc

NBINS = 70;

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
    A = imread(paths{i});
    %imshow(A);
    %C = getrect;
    %C = A(C(2):C(2)+C(4), C(1):C(1)+C(3), :);
    crops{i} = normColors(A);
    %A = normColors(A);
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


Mdl = fitcknn(Hists,Labels, 'NumNeighbors',4);




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


Y_pred = [];
Y_true = [];

correct = 0;
precision = 0;
precision_fl = 0;

for i = 1:num_paths
    I = imread(paths{i});
    %imshow(I);
    [r c] = size(I(:,:,1));
    
    
    saltos_c = 18;
    saltos_r = 18;
    cs = fix(c/saltos_c);
    rs = fix(r/saltos_r);
    R = 0;
    score_barcelona = 0;
    score_chelsea = 0;
    score_juventus = 0;
    score_liverpool = 0;
    score_madrid = 0;
    score_milan = 0;
    score_psv = 0;
    resta = 6;
    for k1 = (cs*resta):cs:c-(cs*resta)
        for k2 = (rs*6):rs:r-(rs*6)
            c_end = min(k1+cs, c);
            r_end = min(k2+rs, r);
            k1_start = max(k1, 1);
            k2_start = max(k2, 1);
            M = I(k2_start:r_end, k1_start:c_end, :);
            %imshow(M);
            %M = normColors(M);
            [R, bins] = imhist(M(:,:,1), NBINS);
            [G, bins] = imhist(M(:,:,2), NBINS);
            [B, bins] = imhist(M(:,:,3), NBINS);
            X = HistNorm([R' G' B']')';
            
            [label,score_aux,cost] = predict(Mdl,X);
            
            frontera = 0;
            
            if label == 1
                score_barcelona = score_barcelona + 1;
            end
            if label == 2
                score_chelsea = score_chelsea + 1;
            end
            if label == 3
                score_juventus = score_juventus + 1;
            end
            if label == 4
                score_liverpool = score_liverpool + 1;
            end
            if label == 5
                score_madrid = score_madrid + 1;
            end
            if label == 6
                score_milan = score_milan + 1;
            end
            if label == 7
                score_psv = score_psv + 1;
            end
        end
    end
    
    all_scores = [score_barcelona score_chelsea score_juventus score_liverpool score_madrid score_milan score_psv];
    [M, I] = max(all_scores);
    score = all_scores(I);
    
        
    if contains(paths{i}, Label_teams{I})
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






