function Matriz
%
% Vamos a hacer una matriz A y B. Calculamos su traza y promedio de A.
% Creamos el vector w def por wi = e^(3-bi), i =1,..,9
% Por ultimo resolvemos el sis Ax = B
%
B = 3:3:27;
a = 6*ones(1,9);
b = (-1)*ones(1,8);
c = (-2)*ones(1,8);
A = diag(a)+diag(b,-1)+diag(c,1);
A(1,1)=7;
A(9,9)=7
traza = trace(A)
promedio=mean (mean(A))
w=[];
for k = 1:9
    w = [(exp(3-B(k))),w]
end
rangoA = rank(A)
ampliada = [A,B'];
rangoAmpliada = rank(ampliada)
x = A\B'
    