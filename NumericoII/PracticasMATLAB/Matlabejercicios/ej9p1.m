function ej9p1

% rA = rank (A), rAb = rank ([A,b])
% n = length (b)
% if rA == n % SCD
    % dis ()
    % x = A\b
    % disp ('COmprobacion')
    % disp (A*x-b)

% elseif rA == rAb % SCI
% else % SI
    %end

% APARTADO e)

% Ae = [2,2,0,1; 2,-2,1,0; 1,0,-1,1; -4,4,-2,0];
% be = [1;-2;0;1];
%  USANDO ESTE PODEMOS USAR UN MISMO PROGRAMA PARA VARIAS MATRICES

rAe = rank (Ae);
rAbe = rank ([Ae,be]);
n = length (be);

if rAe == n
    disp ('SCD')
elseif rAe == rAbe
    disp ('SCI')
else 
    disp ('SI')
end
    xe = Ae\be;
    disp (' Comprobación: ')
    disp (Ae*xe - be)

