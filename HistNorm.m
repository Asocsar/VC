function HO = HistNorm(HI)
%le pasas un vector que define un histograma y te devuelve el mismo
%normalizado, todo suma 1
HO = HI/norm(HI);
end

