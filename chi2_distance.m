function [dist] = chi2_distance(hist1, hist2)
    epsilon = 0.00001;
    dist = sum((hist1 - hist2).^2 ./ (hist1 + hist2 + epsilon));
end

