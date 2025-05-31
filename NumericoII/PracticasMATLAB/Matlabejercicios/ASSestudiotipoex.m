function [u,n] = ASSestudiotipoex (x0,y0,Nmax, g, epsilon)

% devuelve aprox de un punto fijo de x = g(x) y el numero de iteraciones

u = [x0,y0];
for n = 1:Nmax
    u0 = u;
    u = g(u(1),u(2)); 
    if norm (u - u0) < epsilon 
        return
    end
   u0=u;
end
warning ('iteraciones máx sin test de parada. ')

% En pto fijo
% g = @(x,y) [x.^2 + y.^2; x + y.^2]; 
% x0 = 0;
% y0 = 0;
% Nmax = 100;
% epsilon = 1.e-4;