function Res = hist_similarity(Hists,H)
threshold = 50;

[sizeH, elements] = size(H);
[n, m] = size(Hists);

mean = 0;
Res = 0;

for i = 1:3:elements
    if true
        R = H(:,i);
        G = H(:,i+1);
        B = H(:,i+2);
%         Image = cat(3, R, G, B);
%         imshow(Image);
        for j = 1:3:m
            dist1 = chi2_distance(R, Hists{j}(:,1));
            dist2 = chi2_distance(G, Hists{j+1}(:,1));
            dist3 = chi2_distance(B, Hists{j+2}(:,1));
            mean_dist = (dist1+dist2+dist3)/3;
            mean = mean + mean_dist;
%             if Res == 0
%                 Res = mean_dist;
% 
%             elseif mean_dist < Res
%                 Res=mean_dist;
%             end
        end
    end
    
end
Res = mean/(elements/3);
%Res = 1;
end


%dist1 = chi2_distance(R, Means{1});
%dist2 = chi2_distance(G, Means{2});
%dist3 = chi2_distance(B, Means{3});
%p = normcdf(dist1, Mean_R, Std_R);
%dist = sum((hist1 - hist2).^2 ./ (hist1 + hist2));
%p = pdist2(R', Means{1}');

