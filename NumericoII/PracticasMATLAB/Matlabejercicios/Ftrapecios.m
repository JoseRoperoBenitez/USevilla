function [v] = Ftrapecios(fcn,a,b,n)

% v = linspace (a,b,n);
% fx = fcn (v);
% h = v(2)-v(1);
% 
% sol = (sum (h*(fx(1:end-1)+fx(2:end))))*.5; %los limites de integracion
% disp (sol);

% Estudio

x = linspace (a,b,n);
fx = fcn (x);

z = (x(2:end) - x(1:end-1)).*(fx(1:end-1)+fx(2:end));
v = (sum (z))*.5; %los limites de integracion
disp ('La solución es: ')
% disp (v)