function [w1, w2] = SinCos(N)
%
% Recibe como argumento de entrada un número natural N y devuelve un vector
% w1 formado por los múltiplos de 3 entre -3 y 3N cuyo seno sea menor o
% igual que su coseno, y otro vector w2 formado por los múltiplos de 3 
% entre -3 y 3N que verifiquen la condición contraria.
%
w1 = [];
w2 = [];
for k = -3:3:3*N
    if sin(k)<=cos(k)
        w1 = [w1,k];
    else
        w2 = [w2,k];
    end
end
disp(['La sol w1:',num2str(w1),'La sol w2:',num2str(w2)])


% Para que nos salga tanto la solución de w1 como de w2 ponemos en la
% ventana de comando [w1,w2] = SinCos(N).