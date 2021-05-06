clear

fid = fopen('Barza_Camisetaz.txt');
paths = [];
tline = fgetl(fid);
paths = [paths; tline];
while ischar(tline)
    tline = fgetl(fid);
    if ischar(tline)
        paths = [paths; tline];
    end
end
fclose(fid);

num_paths = length(paths(:, 1));
HRL = [];
HGL = [];
HBL = [];
Hists = zeros(num_paths,3);

colors = ["red" , "green" , "blue"];
crops = {};

for i = 1:num_paths
    A = imread(paths(i, :));
    C = imcrop(A);
    crops{i} = C;
    
end


for k = 1:3
    fig = figure; 
    tlo = tiledlayout(fig,2,4,'TileSpacing','Compact');
    for i = 1:num_paths
        C = crops{i}(:,:,k);
        ax = nexttile(tlo);     
        histogram(C, 10, 'FaceColor', colors(k));
        axis on
        hold on
        Hists(i,k) = histogram(C, 10, 'FaceColor', colors(k));
    end
end

Means = zeros(3);
for i = 1:3
    m = 0;
    for k = 1:num_paths
        m = sum(Hists(k,i));
    end
    Means(i) = m./num_paths;
end



%dist = chi2_distance(HR.Data,HR1.Data);
