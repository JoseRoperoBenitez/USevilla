function [u,k] = Whittakerex22 (f,df,x0,y0,Eps,Nmax)

M = df(x0,y0);
u = [x0;y0];

for k = 1:Nmax
    u0=u;
    if (mod(k,5)==0)
        M = df(u(1),u(2));
        
    end
    u = u - M\(f(u(1),u(2)));
    if norm(f(u(1),u(2)))< Eps
        return
    end
    if norm(u-u0)< Eps
        return
    end
    
end
warning ('Numero max de iteraciones alcanzadas.')
    

