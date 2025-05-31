function ej10p1

A = [10 1 4 0
    1 10 5 -1
    4 5 10 7
    0 -1 7 9];
disp ('diversos números de condición: ')
cond (A,1)
cond (A,2)
cond (A,"inf")
b = [15; 15; 26; 15];

% PARA SACAR AUTOVALORES "eig(A)"


disp ('autovalores y auctovectores de A: ')
[V,D] = eig(A)

disp ('uso simplificado del eig: ')
eig(A)