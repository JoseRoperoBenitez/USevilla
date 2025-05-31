function [x,Iter] = Newton28 (f,fp,x0,Nmax,epsilon)

% >> [x,Iter] = Newton (f,fp,x0,Nmax,epsilon)
% >> [x,Iter] = Newton28 (@(x) x+log(x/3), @(x) 1 + 1/x, 1, 100, 1e-2)

x = x0; % MUCHA ATENCION CON ESTO
for Iter = 1:Nmax
    fx=f(x);
    if abs (fx)<epsilon 
        Iter = Iter-1; % aqui no ha hecho ninguna iteración y por eso le 
                       % resta una iteración
        return
    end
    dfx = fp(x); 
    if abs (dfx)<epsilon
        warning ('metodo interrumpido, derivada muy cercana a cero')
        return
    end
    res = fx/dfx;
    x = x-res; %iteracion x_{n+1} Mn en termino de x_n

    formatSpec = 'Iteracion %2d, x(%2d)=%16.14f,res=%8e\n';

    fprintf (formatSpec, Iter, Iter, x, res)

    if  abs(res)<epsilon % primera iteración
        return 
    end
end
warning ('num.max iteraciones completo sin test de parada.')