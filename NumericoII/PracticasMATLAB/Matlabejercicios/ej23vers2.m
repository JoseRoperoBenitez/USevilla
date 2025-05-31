function y=ej23vers2(x)

% Versión vectorizada

n = length (x);
y = zeros(size(x)); %Para optimizar la y y tener cuidado con hacer cosas vectorizadas.
for i = 1:n
if x(i)<0
    y(i) = -x(i);
else 
    y(i) = exp(x(i))-1;
end
end