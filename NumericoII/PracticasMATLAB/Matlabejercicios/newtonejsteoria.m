function [x,n] = newtonejsteoria(f,df,x,Nmax,epsilon,tol)

for n = 1:Nmax
    fx = f(x);
    if norm(fx)<tol
        n=n-1;
        return
    end
    dfx=df(x);
    if abs(det(dfx))<tol
        warning ('Riesgo jacobiano singular. Stop')
        return
    end
    delta =dfx\fx; x=x-delta;
    if norm(delta)<epsilon
        return
    end
end
warning ('se ha llegado a nmax iteraciones')
end

% se hace con esto problema 39,37

% es util el fimplicit para encontrar sols de las funciones
% buscar el comando solve