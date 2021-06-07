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
    A = imread(paths{i});
    %imshow(A);
    %C = getrect;
    %C = A(C(2):C(2)+C(4), C(1):C(1)+C(3), :);
    crops{i} = normColors(A);
    A = normColors(A);
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

%Labels_barcelona = int8(Labels == 1);
%Labels_chelsea = int8(Labels == 2);
%Labels_juventus = int8(Labels == 3);
%Labels_liverpool = int8(Labels == 4);
%Labels_madrid = int8(Labels == 5);
%Labels_milan = int8(Labels == 6);
%Labels_psv = int8(Labels == 7);

Tree = [100, [Hists_barcelona; Hists_chelsea; Hists_juventus; Hists_liverpool; Hists_madrid; Hists_milan; Hists_psv], Labels];

% Mdl_barcelona = fitcsvm(Hists_barcelona,Labels_barcelona, 'KernelFunction', 'rbf');
% Mdl_chelsea = fitcsvm(Hists_chelsea,Labels_chelsea, 'KernelFunction', 'rbf');
% Mdl_juventus = fitcsvm(Hists_juventus,Labels_juventus, 'KernelFunction', 'rbf');
% Mdl_liverpool = fitcsvm(Hists_liverpool,Labels_liverpool, 'KernelFunction', 'rbf');
% Mdl_madrid = fitcsvm(Hists_madrid,Labels_madrid, 'KernelFunction', 'rbf');
% Mdl_milan = fitcsvm(Hists_milan,Labels_milan, 'KernelFunction', 'rbf');
% Mdl_psv = fitcsvm(Hists_psv,Labels_psv, 'KernelFunction', 'rbf');

%Mdl_barcelona = fitcsvm(Hists,Labels_barcelona, 'Standardize', true);
%Mdl_chelsea = fitcsvm(Hists,Labels_chelsea, 'Standardize', true);
%Mdl_juventus = fitcsvm(Hists,Labels_juventus, 'Standardize', true);
%Mdl_liverpool = fitcsvm(Hists,Labels_liverpool, 'Standardize', true);
%Mdl_madrid = fitcsvm(Hists,Labels_madrid, 'Standardize', true);
%Mdl_milan = fitcsvm(Hists,Labels_milan, 'Standardize', true);
%Mdl_psv = fitcsvm(Hists,Labels_psv, 'Standardize', true);




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
precision = 0;
precision_fl = 0;

for i = 1:num_paths
    I = imread(paths{i});
    %imshow(I);
    [r c] = size(I(:,:,1));
    
    
    saltos_c = 8;
    saltos_r = 8;
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
    for k1 = 3:cs:c-3
        for k2 = 3:rs:r-3
            c_end = min(k1+cs, c);
            r_end = min(k2+rs, r);
            k1_start = max(k1, 1);
            k2_start = max(k2, 1);
            M = I(k2_start:r_end, k1_start:c_end, :);
            %imshow(M);
            M = normColors(M);
            [R, bins] = imhist(M(:,:,1), NBINS);
            [G, bins] = imhist(M(:,:,2), NBINS);
            [B, bins] = imhist(M(:,:,3), NBINS);
            X = HistNorm([R' G' B']')';
%             [label_barcelona,score_tree_barcelona] = predict(Tree,X);
%             [label_chelsea,score_tree_chelsea] = predict(Tree,X);
%             [label_juventus,score_tree_juventus] = predict(Tree,X);
%             [label_liverpool,score_tree_liverpool] = predict(Tree,X);
%             [label_madrid,score_tree_madrid] = predict(Tree,X);
%             [label_milan,score_tree_milan] = predict(Tree,X);
%             [label_psv,score_tree_psv] = predict(Tree,X);
            [label, score] = predict(Tree,X);
            
%             if score_tree_barcelona > 0  && score_tree_barcelona < 15
%                 score_barcelona = score_barcelona + 1;
%             end
%             if score_tree_chelsea > 0 && score_tree_chelsea < 15
%                 score_chelsea = score_chelsea + 1;
%             end
%             if score_tree_juventus > 0 && score_tree_juventus < 15
%                 score_juventus = score_juventus + 1;
%             end
%             if score_tree_liverpool > 0 && score_tree_liverpool < 15
%                 score_liverpool = score_liverpool + 1;
%             end
%             if score_tree_madrid > 0 && score_tree_madrid < 15
%                 score_madrid = score_madrid + 1;
%             end
%             if score_tree_milan > 0 && score_tree_milan < 15
%                 score_milan = score_milan + 1;
%             end
%             if score_tree_psv > 0 && score_tree_psv < 15
%                 score_psv = score_psv + 1;
%             end
            
            %if label_barcelona > 0
            %    score_barcelona = score_barcelona + 1;
            %end
            %if label_chelsea > 0
            %    score_chelsea = score_chelsea + 1;
            %end
            %if label_juventus > 0
            %    score_juventus = score_juventus + 1;
            %end
            %if label_liverpool > 0
            %    score_liverpool = score_liverpool + 1;
            %end
            %if label_madrid > 0
            %    score_madrid = score_madrid + 1;
            %end
            %if label_milan > 0
            %    score_milan = score_milan + 1;
            %end
            %if label_psv > 0
            %    score_psv = score_psv + 1;
            %end
        end
    end
    
%     all_scores = [score_barcelona score_chelsea score_juventus score_liverpool score_madrid score_milan score_psv];
%     [M, I] = max(all_scores);
%     score = all_scores(I);
% 
%         
%     if contains(paths{i}, Label_teams{I})
%         correct = correct + 1;
%     end
table(Classifier.ClassNames,label,max(score)','VariableNames',{'Name','Label','Score'})
sum(max(score))/30
   
    
end


correct = correct/num_paths;
disp(["Accuracy of", correct*100, "%"]);
% disp(["Precision of", (precision/(precision+precision_fl))*100, "%"]);