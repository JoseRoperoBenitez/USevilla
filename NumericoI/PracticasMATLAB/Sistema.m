function Sistema
%
% matriz banda A de 10 ⇥ 10 que tenga 20,18,. . . 4,2 en la diagonal 
% principal, 2 en las dos primeras diagonales secundarias superior e 
% inferior
%
a = 20:-2:2;
b = 2*ones (1,9);
A = diag(a) + diag(b,1) + diag(b,-1);

b = 1:10;
b = b';
x = A\b

%Podemos comprobar que existe tb la sol con el rank.