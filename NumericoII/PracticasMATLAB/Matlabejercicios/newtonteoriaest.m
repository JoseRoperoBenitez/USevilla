function [x,Iter] = newtonteoriaest (f,df,x,Nmax,Eps)

% [x,Iter] = newtonteoriaest (@(x) x+log(x/3), @(x) 1 + 1/x, 1, 100, 1e-2)

for Iter = 1:Nmax
    fx = f(x);
    if norm(fx)<Eps
        Iter = Iter-1;
        return
    end
    dfx = df(x);
    if abs(det(dfx))<Eps
        warning ('Riesgo jacobiano singular. Stop')
        return
    end
    delta = fx/dfx;
    x = x - delta;

    disp (['Iter:', num2str(Iter), '  Residuo:', num2str(delta)])
    if norm(delta) <Eps
        
        return
    end
end
warning('Num max de iteraciones alcanzado.')



