clear
close all
clc

NBINS = 25;

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
Hists = {};%zeros(num_paths,3);

colors = ["red" , "green" , "blue"];
crops = {};

meanN = 0;
meanM = 0;
for i = 1:num_paths
    A = rgb2hsv(imread(paths{i}));
    C = A;
    %C = getrect;
    %C = A(C(2):C(2)+C(4), C(1):C(1)+C(3), :);
    crops{i} = C;%normColors(C);
    [nC, mC] = size(C(:,:,1));
    meanN = meanN + nC;
    meanM = meanM + mC;
end

meanN = meanN/num_paths;
meanM = meanM/num_paths;

%COMPUTE AND SHOW LOCAL TRAIN HIST
for k = 1:3
    %fig = figure; 
    %tlo = tiledlayout(fig,2,4,'TileSpacing','Compact');
    for i = 1:num_paths
        C = crops{i}(:,:,k);
        %ax = nexttile(tlo);     
        %histogram(C, NBINS, 'FaceColor', colors(k));
        %axis on
        %hold on
        [counts, binLoc] = imhist(C, NBINS);
        key = k + (i-1)*3;
        Hists{key} = [counts binLoc];
        %Hists{100 + key} = C;
        Hists{key}(:,1) = HistNorm(Hists{key}(:,1));
    end
end

whiteM = 0;
blackM = 0;
key = 3;
for i = 1:num_paths
   C = crops{i}(:,:,3);
   [r c] = size(C);
   whiteMask = C > 0.85;
   blackMask = C < 0.15;
   whiteM = sum(sum(whiteMask));
   %dividim entre el total de la imatge per normalitzarho segons els pixels
   whiteM = whiteM / (r*c);
   blackM = sum(sum(blackMask));
   blackM = blackM / (r*c);
   masks = cat(2, whiteM, blackM);
   Hists{key} = masks;
   key = key + 3;
end



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
m = fix(meanM);
n = fix(meanN);



correct = 0;
precision = 0;
precision_fl = 0;

EKIP = zeros(1,7);

for i = 1:num_paths
    I = rgb2hsv(imread(paths{i}));
    %imshow(I);
    [r c] = size(I(:,:,1));
    
    
%     C = getrect;
%     C = I(C(2):C(2)+C(4), C(1):C(1)+C(3), :);
%     imshow(C);
%    R = historiogramaBins(crops{1}, NBINS, Hists);
    
    for equips = 1:7
        
    
        saltos_c = 3;
        saltos_r = 3;
        cs = fix(c/saltos_c);
        rs = fix(r/saltos_r);
        R = 0;
        for k1 = 1:cs:c
            for k2 = 1:rs:r
            c_end = min(k1+cs, c);
            r_end = min(k2+rs, r);
            %k1_start = max(k1, 1);
            %k2_start = max(k2, 1);
            M = I(k2:r_end, k1:c_end, :);
            %imshow(M);
            R = max(R, uint8(historiogramaBins(M, NBINS, Hists(:,(15*equips)-14:15*equips))));
            
            end
        end
        
        EKIP(equips) = R;
    end
    
    %pos = quin equip es
    [maxim, pos] = max(EKIP);
    
    if pos == 1
        disp(paths{i});
        disp(["Image is from barça"]);
        disp([R]);
        if i <= 36
            correct = correct + 1;
        end
    elseif pos == 2
        disp(paths{i});
        disp(["Image is from chelsea"]);
        disp([R]);
        if (i>36 && i<=72)
            correct = correct + 1;
        end
    elseif pos == 3
        disp(paths{i});
        disp(["Image is from juve"]);
        disp([R]);
        if (i>72 && i<=108)
            correct = correct + 1;
        end
    elseif pos == 4
        disp(paths{i});
        disp(["Image is from liverpool"]);
        disp([R]);
        if (i>108 && i<=144)
            correct = correct + 1;
        end
    elseif pos == 5
        disp(paths{i});
        disp(["Image is from madrid"]);
        disp([R]);
        if (i>144 && i<=180)
            correct = correct + 1;
        end
    elseif pos == 6
        disp(paths{i});
        disp(["Image is from milan"]);
        disp([R]);
        if (i>180 && i<=216)
            correct = correct + 1;
        end
    elseif pos == 7
        disp(paths{i});
        disp(["Image is from psv"]);
        disp([R]);
        if i>216
            correct = correct + 1;
        end
    end
    
end


correct = correct/num_paths;
disp(["Accuracy of", correct*100, "%"]);
%disp(["Precision of", (precision/(precision+precision_fl))*100, "%"]);

function Res = historiogramaBins(Image_data, NBINS, Hists)

%Image_data = double(Image.data);
%figure;
%imshow(Image_data);


H = Image_data(:, :, 1);
%R(all(~R,2), : ) = [];
%R( :, all(~R,1) ) = [];
%R = R - 1;
%R = uint8(R);
%figure
%imhist(R);

S = Image_data(:, :, 2);
%G(all(~G,2), : ) = [];
%G( :, all(~G,1) ) = [];
%G = G - 1;
%G = uint8(G);

V = Image_data(:, :, 3);
%B(all(~B,2), : ) = [];
%B( :, all(~B,1) ) = [];
%B = B - 1;
%B = uint8(B);

% [r1, r2] = size(R);
% [g1, g2] = size(G);
% [b1, b2] = size(B);


I = cat(3,H,S,V);

%I = normColors(I);
H = HistNorm(imhist(I(:, :, 1), NBINS));
S = HistNorm(imhist(I(:, :, 2), NBINS));
%V = HistNorm(imhist(I(:, :, 3), NBINS));


[n, m] = size(Hists);

mean = 0;
threshold = 5;%0.17;%6;%0.2;
threshold2 = 4;
thresholdB = 0.01;
thresholdW = 0.01;
for j = 1:3:m
    dist1 = pdist2(H', Hists{j}(:,1)', 'emd');
    dist2 = pdist2(S', Hists{j+1}(:,1)', 'emd');
    %dist3 = pdist2(V', Hists{j+2}(:,1)', 'emd');
    
    WM = Hists{j+2}(1);
    BM = Hists{j+2}(2);
    
    [nv, mv] = size(V);
    
    whiteMask = V > 0.85;
    blackMask = V < 0.15;
    half = (nv*mv)/2;
    white = sum(sum(whiteMask));
    white = white / (nv*mv);
    black = sum(sum(blackMask));
    black = black / (nv*mv);
    
    distW = abs(white-WM);
    distB = abs(black-BM);
    
    mean = mean + (dist1 < threshold) + (dist2 < threshold2) + (distW < thresholdW) + (distB < thresholdB);
    
end


Res = mean;

end



