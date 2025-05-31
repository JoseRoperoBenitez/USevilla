function [amax] = MayorM(A)
%
% MayorM (A) es el maximo de los valores absolutos de las componentes de 
% matriz A (tienen filas y columnas (2 índices)).
%
amax = 0;
[nf,nc] = size (A);
for i = 1 : nf
    for j = 1 : nc
        aij = abs(A(i,j));
        if aij > amax
            amax = aij;
        end
    end
end

% Ponemos dos for ya que tenemos que guardar y considerar tanto el numero
% de filas como de columnas.