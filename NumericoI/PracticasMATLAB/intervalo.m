function y = intervalo (a,b)
%
% la función te va a pedir un x que tiene que estar en [a,b].
%
x = input ('Da un número dentro de ese intervalo');
while (x<a)||(x<b)
    x = input ('Vuelve a dar el número');
end
disp('Está dentro !!')

% Con (x<a)|(x<b) decimos que x no pertenece al intervalo (a,b).