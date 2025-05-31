function [sol] = FSimpson (fcn,a,b,n)
% f = @(x) exp(-x.^2);
% [v]= FSimpson (@(x) exp(-x.^2),0,1,16)
% v = linspace (a,b,n);
% fx = fcn(v);
% h1 = v(2)-v(1);
% 
% 
% sol = (1/6)*(sum(h1*(fx(1:end-1) + 4*fcn((v(1:end-1)+v(2:end))*.5) + fx(2:end))));
% Cuidado aqui con donde analizo la funcion fx sobre un v y donde la fcn
% sobre otro "v"

% v = 0;
% x = linspace(a,b,n);
% for i = 1:n-1
%     x1 = x(i);
%     x2 = x(i+1);
%     
%     v = v + 1/6*(x2-x1)*(fcn(x1) + 4*fcn((x1+x2)./2) + fcn(x2));
% end

% Estudio

x = linspace (a,b,n);
fx = fcn(x);

z = (x(2:end) - x(1:end-1)) .* ((fx(1:end-1) + 4*fcn((x(1:end-1) + x(2:end))*.5) ...
                                + fx(2:end)));
sol = 1/6 * sum(z);
