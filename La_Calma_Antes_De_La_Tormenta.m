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



A = imread(paths(1, :));
B = imread(paths(2, :));

%figure; imshow(A);
%figure; imshow(B);
%[f, c, d] = size(I);

M = imcrop(A);
N = imcrop(B);
%figure; imshow(M);

R = M(:,:,1);
G = M(:,:,2);
B = M(:,:,3);

R1 = N(:,:,1);
G1 = N(:,:,2);
B1 = N(:,:,3);


figure;
HR = histogram(R, 10, 'FaceColor', 'red');
%figure;
%HG = histogram(G, 'FaceColor', 'green');
%figure;
%HB = histogram(B, 'FaceColor', 'blue');

figure;
HR1 = histogram(R1, 10, 'FaceColor', 'red');


%dist = chi2_distance(HR.Data,HR1.Data);