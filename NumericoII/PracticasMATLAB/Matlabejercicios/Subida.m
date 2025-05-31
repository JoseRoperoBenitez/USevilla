function [x] = Subida (A, b)

n = length (b);
x = zeros (size (b));

suma = 0;
for i = n:-1:1
    for j = i+1:n
        suma = suma + A(i,j)*x(j);
    end
    x(i) = (b(i) - suma)/A(i,i);
end
    