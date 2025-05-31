function [s1, s2] = SumaSepara(v) 
%
% recibe como argumento de entrada un vector v y devuelve: 
% s1 = la suma de las componentes de v que sean menores o iguales que 0 
% s2 = la suma de las componentes de v que sean estrictamente mayores que 8
%
s1 = 0;
s2 = 0;
for k = 1: length (v)
    if v(k) <= 0
        s1 = s1 + v(k);
    elseif v(k) > 8
        s2 = s2 + v(k);
    end
end
disp([num2str(s1),' y ', num2str(s2)])
% Para que nos devuelva tanto s1 como s2 en la ventana de comandos debemos
% poner [s1,s2] = SumaSepara ([v]).