function [dist] = chi2_distance(hist1, hist2)
    dist = sum((hist1 - hist2).^2 ./ (hist1 + hist2));
end

