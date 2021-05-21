function C = normColors(I)

    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
    Max = max(max(double(R)+double(G)+double(B)));
    
    R = double(R)/Max;
    G = double(G)/Max;
    B = double(B)/Max;

    C = cat(3,R,G,B);
end