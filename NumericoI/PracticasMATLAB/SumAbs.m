function [vsum] = SumAbs(v)
%
% devuelve la suma de los valores absolutos de los elementos del vector v.
%
vsum = 0;
for k = 1:(length(v))
    vsum = vsum + abs (v(k));
end