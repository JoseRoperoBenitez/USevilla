function [V] = F2Simpson (f,x)


x = linspace (x(1), x(end),length(x));

fx = f(x);

z = (x(2:end) - x(1:end-1)).*(fx(1:end-1) + 3*f((2*x(1:end-1) + ... 
                                             x(2:end))/3) + ...
                                             3*f((x(1:end-1) + ...
                                             2*x(2:end))/3) ...
                                             + fx(2:end));
V = 1/8 * (sum (z));




