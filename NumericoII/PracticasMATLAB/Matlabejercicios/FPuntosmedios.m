function [v] = FPuntosmedios(fcn,a,b,n)
% v=0;
% % Ejercicio 13
% x=linspace(a,b,n);
% for i = 1:n-1
%     x1=x(i);
%     x2=x(i+1);
%     v=v+(x2-x1)*fcn((x1+x2)./2);
% end




% Estudio

% Mediante nodos no equiespaciados

x = linspace (a,b,n);

z = (x(2:end) - x(1:end-1)) .* (fcn ((x(1:end-1) + x(2:end)).*.5));
v = (sum (z));
% disp (v)

% fcn = @(x) exp(-x.^2);

% Mediante Bucles

% v = 0;
% x = linspace (a,b,n);
% for i = 1:n-1
%     x1 = x(i);
%     x2 = x(i+1);
%     v = v + (x2 - x1)* fcn((x1+x2).*.5);
% end



