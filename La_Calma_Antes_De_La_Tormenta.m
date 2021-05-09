clear

NBINS = 10

fid = fopen('Barza_Camisetaz.txt');
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
Hists = {}%zeros(num_paths,3);

colors = ["red" , "green" , "blue"];
crops = {};

for i = 1:num_paths
    A = imread(paths{i});
    C = imcrop(A);
    crops{i} = C;
    
end

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
        Hists{key} = [counts, binLoc];
    end
end

Means = {}
for i = 1:3
    for k = 1:num_paths
        key = k + (i-1)*3;
        if k == 1
            m = Hists{key}(:, 1);
        else
            m = m + Hists{key}(:, 1);
        end
    end
    Means{i} = m./num_paths;
end


% SHOW MEAN TRAIN
% fig = figure; 
% tlo = tiledlayout(fig,1,3,'TileSpacing','Compact');
% for i = 1:3
%    ax = nexttile(tlo);
%    bar(Hists{key}(:, 2),Means{i},'hist');
%    axis on
%    hold on
% end

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



%dist = chi2_distance(HR.Data,HR1.Data);
