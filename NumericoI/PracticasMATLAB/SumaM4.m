function [flag] = SumaM4(v)
%
% reciba como argumento de entrada un vector v y devuelva flag=1 si la 
% suma de las componentes de dicho vector es mayor estricto que 4 y 
% flag=0 en caso contrario
%
flag = 0;
suma = 0;
for k = 1:length(v)
    suma = suma + v(k);
    if suma > 4
        flag = 1;
    end
end