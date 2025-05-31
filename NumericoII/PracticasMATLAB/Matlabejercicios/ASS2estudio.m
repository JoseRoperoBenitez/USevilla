function [x1,n] = ASS2estudio (x0, Nmax, g, epsilon)

for n = 1:Nmax
    x1 = g(x0); 
    res = abs (x1-x0);

    disp (['iter: ', num2str(n), ' valor aprox: ', num2str(x1), ...
    '  valor del residuo: ', num2str(res)])

%     formatSpec = 'iter. %2d , x(%2d)=%8.6f, res=%8.6f\n';
% fprintf (formatSpec, n,n,x1,res)

     if res<epsilon
        return
    end
    x0=x1;
end
warning ('iteraciones máximas completas sin test de parada. ')





% >> [x,n] = ASS2estudio (1,100,@(x) -log(x/3), 1e-4)