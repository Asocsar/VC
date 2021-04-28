clear

fid = fopen('Barza_Camisetaz.txt');
paths = []
tline = fgetl(fid);
paths = [paths; tline]
while ischar(tline)
    tline = fgetl(fid);
    if ischar(tline)
        paths = [paths; tline]
    end
end
fclose(fid);



IM = imread(paths(1, :));
imshow(IM);
