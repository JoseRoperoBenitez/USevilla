function [x1,n] = AASS2 (x0,Nmax,g,epsilon)

% Ej 26
% >> [x1,n] = AASS (x0,Nmax,g,epsilon) Ej 25
% >> [x,n] = AASS (1,100,@(x) -log(x/3), 1e-4) EJERCICIO 30, la fun es de
% punto fijo, x = g(x)
for n = 1:Nmax
    x1 = g(x0); res = abs (x1-x0);
%     disp (['iter.', num2str(n), 'x(', num2str(n),')',...
%         num2str(x1), 'res=', num2str(res)])

formatSpec = 'iter. %2d , x(%2d)=%8.6f, res=%8.6f\n';
fprintf (formatSpec, n,n,x1,res)
    if res<epsilon
        return
    end
    x0=x1;
end
warning ('iteraciones máximas completas sin test de parada. ')

% Ver fprintf para cambios de formato