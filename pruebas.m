clear 
A = imread('01.jpg');


m = 20;
n = 20;

nbins = 255;

fun = @(x) imhist(x.data(:), nbins);

R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);

BR = blockproc(R,[m n], fun, 'BorderSize', [15 15], 'TrimBorder', false, 'PadPartialBlocks', true, 'UseParallel', true);

BG = blockproc(G,[m n], fun, 'BorderSize', [15 15], 'TrimBorder', false, 'PadPartialBlocks', true, 'UseParallel', true);

BB = blockproc(B,[m n], fun, 'BorderSize', [15 15], 'TrimBorder', false, 'PadPartialBlocks', true, 'UseParallel', true);

[r, c] = size(BR);
BR = reshape(BR, nbins, (r/nbins)*c);
BG = reshape(BG, nbins, (r/nbins)*c);
BB = reshape(BB, nbins, (r/nbins)*c);

Historiogramas = {BR, BG, BB};
colors = {[1. 0. 0.], [0. 1. 0.], [0. 0. 1.]};


fig = figure; 
tlo = tiledlayout(fig,1,3,'TileSpacing','Compact');
for i = 1:3
    ax = nexttile(tlo);
    hist(Historiogramas{i}(2:nbins, 180), 10) %hist(1:nbins-1, Historiogramas{i}(2:nbins, 180));
    h = findobj(gca, 'Type', 'patch');
    h.FaceColor = colors{i};
    axis on
    hold on
end
