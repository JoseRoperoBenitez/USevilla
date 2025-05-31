function ConstruccionMatriz
%
% % Una matriz banda de 20 × 20 que tenga 1, 2,. . . , 20 en la diagonal 
% principal, −1 en las dos primeras diagonales secundarias (superior e 
% inferior) y −2 en las dos segundas diagonales secundarias (superior e
% inferior).
%
a = 1:20;
b = (-1)*ones(1,19);
c = (-2)*ones(1,18);
A = diag(a) + diag(b,1) + diag(b,-1) + diag(c,2) + diag(c,-2)

%  Una matriz banda de 20 × 20 que tenga 3 en la diagonal principal 
% y −1 en las dos primeras diagonales secundarias superior e inferior.

d = 3*ones (1,20);
e = (-10)*ones (1,19);
B = diag(d) + diag (b,1) + diag (e,-1)
