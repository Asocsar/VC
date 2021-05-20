function Res = hist_similarity(Means,H)
threshold = 50;

[sizeH, elements] = size(H);

Res = 0;

for i = 1:3:elements
    if true
        R = H(:,i);
        G = H(:,i+1);
        B = H(:,i+2);
        Image = cat(3, R, G, B);
        imshow(Image);
        
        dist1 = chi2_distance(R, Means{1});
        dist2 = chi2_distance(G, Means{2});
        dist3 = chi2_distance(B, Means{3});
        mean_dist = (dist1+dist2+dist3)/3;
        
        if Res == 0
            Res = mean_dist;
        
        else mean_dist < Res
            Res=mean_dist;
        end
    end
end
%Res = 1;
end


%dist1 = chi2_distance(R, Means{1});
%dist2 = chi2_distance(G, Means{2});
%dist3 = chi2_distance(B, Means{3});
%p = normcdf(dist1, Mean_R, Std_R);
%dist = sum((hist1 - hist2).^2 ./ (hist1 + hist2));
%p = pdist2(R', Means{1}');

