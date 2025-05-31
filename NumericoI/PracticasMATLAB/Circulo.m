function [bool] = Circulo(x,y,r)
%
% recibe dos vectores de reales x e y y un real r positivo. Devuelve bool =
% true si (xi,yi) estan estrict dentro circulo centro (0,0), radio r,
% bool = false c.c
%
bool = true; 
for k = 1 : length(x)
    if x(k)^2 + y(k)^2 >= r^2
        bool = false;
    end
end

% Grafica circulo y distintos puntos
t = linspace (-5,5);
a = r*cos(t);
b = r*sin(t);
hold on 
plot(a,b)
for k = 1:length (x)
    plot(x(k),y(k),'k.','MarkerSize',10)
end
plot (0,0,'r.', 'MarkerSize',10)
axis equal
hold off
shg