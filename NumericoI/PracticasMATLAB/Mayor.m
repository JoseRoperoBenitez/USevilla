function [vmax] = Mayor (v)
%
% queremos la mayor componente del vector v
%
vmax = v(1);
for k = 2 : length(v)
    if v(k) > vmax
        vmax = v(k);
    end
end