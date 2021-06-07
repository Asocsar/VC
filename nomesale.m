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
Hists = {};

crops = {};

for i = 1:num_paths
    A = rgb2hsv(imread(paths{i}));
    C = A;
    crops{i} = C;
    [nC, mC] = size(C(:,:,1));
end


for k = 1:3
    for i = 1:num_paths
        C = crops{i}(:,:,k);
        [counts, binLoc] = imhist(C, NBINS);
        key = k + (i-1)*3;
        Hists{key} = counts;
        Hists{key}(:,1) = HistNorm(Hists{key}(:,1));
    end
end

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


correct = 0;

EKIP = zeros(1,7);

Y_pred = [];
Y_true = [];

for i = 1:num_paths
    I = rgb2hsv(imread(paths{i}));
    %imshow(I);
    [r c] = size(I(:,:,1));
    
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
            M = I(k2:r_end, k1:c_end, :);
            
            R = max(R, (historiogramaBins(M, NBINS, Hists(:,(15*equips)-14:15*equips))));
            
            end
        end
        
        EKIP(equips) = R;
    end
    
    %pos = quin equip es
    [maxim, pos] = max(EKIP);
    
    if pos == 1
        disp(paths{i});
        disp(["Image is from barça"]);
        disp([maxim]);
        if i <= 36
            correct = correct + 1;
        end
    elseif pos == 2
        disp(paths{i});
        disp(["Image is from chelsea"]);
        disp([maxim]);
        if (i>72 && i<=108)
            correct = correct + 1;
        end
    elseif pos == 3
        disp(paths{i});
        disp(["Image is from juve"]);
        disp([maxim]);
        if (i>108 && i<=144)
            correct = correct + 1;
        end
    elseif pos == 4
        disp(paths{i});
        disp(["Image is from liverpool"]);
        disp([maxim]);
        if (i>144 && i<=180)
            correct = correct + 1;
        end
    elseif pos == 5
        disp(paths{i});
        disp(["Image is from madrid"]);
        disp([maxim]);
        if (i>180 && i<=216)
            correct = correct + 1;
        end
    elseif pos == 6
        disp(paths{i});
        disp(["Image is from milan"]);
        disp([maxim]);
        if (i>36 && i<=72)
            correct = correct + 1;
        end
    elseif pos == 7
        disp(paths{i});
        disp(["Image is from psv"]);
        disp([maxim]);
        if i>216
            correct = correct + 1;
        end
    end
    
    Y_pred = [Y_pred pos];

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

function Res = historiogramaBins(Image_data, NBINS, Hists)

H = Image_data(:, :, 1);
S = Image_data(:, :, 2);
V = Image_data(:, :, 3);

I = cat(3,H,S,V);

H = HistNorm(imhist(I(:, :, 1), NBINS));
S = HistNorm(imhist(I(:, :, 2), NBINS));


[n, m] = size(Hists);

distmin = 10000;
for j = 1:3:m
    dist1 = pdist2(H', Hists{j}(:,1)', 'emd');
    dist2 = pdist2(S', Hists{j+1}(:,1)', 'emd');
    
    WM = Hists{j+2}(1);
    BM = Hists{j+2}(2);
    
    [nv, mv] = size(V);
    
    whiteMask = V > 0.85;
    blackMask = V < 0.15;
    white = sum(sum(whiteMask));
    white = white / (nv*mv);
    black = sum(sum(blackMask));
    black = black / (nv*mv);
    
    distW = abs(white-WM);
    distB = abs(black-BM);
    
    distmin = min(distmin, dist1/30+dist2/30+distW+distB);
    
end


Res = 1/(distmin^2);

end



