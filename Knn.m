clear
close all
clc

NBINS = 30;

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
Hists = zeros(7,3*NBINS);
for i = 1:num_paths
    A = imread(paths{i});
    %imshow(A);
    %C = getrect;
    %C = A(C(2):C(2)+C(4), C(1):C(1)+C(3), :);
    crops{i} = normColors(A);
    [nC, mC] = size(A(:,:,1));
    meanN = meanN + nC;
    meanM = meanM + mC;
    if contains(paths{i}, 'barcelona')
        Labels(i) = 1;
    elseif contains(paths{i}, 'chelsea')
        Labels(i) = 2;
    elseif contains(paths{i}, 'juventus')
        Labels(i) = 3;
    elseif contains(paths{i}, 'liverpool')
        Labels(i) = 4;
    elseif contains(paths{i}, 'madrid')
        Labels(i) = 5;
    elseif contains(paths{i}, 'milan')
        Labels(i) = 6;
    elseif contains(paths{i}, 'psv')
        Labels(i) = 7;
    end
    
    [countsR, bins] = imhist(A(:,:,1), NBINS);
    [countsG, bins] = imhist(A(:,:,2), NBINS);
    [countsB, bins] = imhist(A(:,:,3), NBINS);

    
    
   
    Hists(i,:) = [countsR' countsG' countsB'];
end


Mdl = fitcknn(Hists,Labels, 'NumNeighbors',4)


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
    score = 0;
    for k1 = 1:cs:c
        for k2 = 1:rs:r
            c_end = min(k1+cs, c);
            r_end = min(k2+rs, r);
            k1_start = max(k1, 1);
            k2_start = max(k2, 1);
            M = I(k2_start:r_end, k1_start:c_end, :);
            %M = normColors(M);
            [R, bins] = imhist(M(:,:,1), NBINS);
            [G, bins] = imhist(M(:,:,2), NBINS);
            [B, bins] = imhist(M(:,:,3), NBINS);
            X = [R' G' B'];
            label = predict(Mdl,X);
            if score_aux >= 0
                score = score + 1;
            end
        end
    end
    
    if score >= 12
        disp(paths{i});
        disp(["Image is from barça"]);
        %disp([R]);
        
        if i <= 36
            correct = correct + 1;
            precision = precision + 1;
        end
    
    elseif i <= 36
        precision_fl = precision_fl + 1;

       
    elseif i >= 37
        correct = correct + 1;
       
    end
    
end


correct = correct/num_paths;
disp(["Accuracy of", correct*100, "%"]);
disp(["Precision of", (precision/(precision+precision_fl))*100, "%"]);

function Res = historiogramaBins(Image_data, NBINS)


R = Image_data(:, :, 1);
G = Image_data(:, :, 2);
B = Image_data(:, :, 3);



[r1, r2] = size(R);
[g1, g2] = size(G);
[b1, b2] = size(B);


I = cat(3,R,G,B);

%I = normColors(I);

mean = 0;
threshold = 0.23;

for j = 1:3:m
    dist1 = 0;%pdist2(R', Hists{j}(:,1)', 'chisq');
    dist2 = 0;%pdist2(G', Hists{j+1}(:,1)', 'chisq');
    dist3 = 0;%pdist2(B', Hists{j+2}(:,1)', 'chisq');
    
    
    mean = mean + (dist1 < threshold) & (dist2 < threshold) & (dist3 < threshold);
    
end


Res = mean;

end






