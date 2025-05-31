function[x]=ejercicio1(x0,nmax)

f=@(x) [x(1)-2*x(1)*exp(-x(2));
        x(2)-2*x(1)*(1-exp(-x(2)))];
    
df=@(x) [1-2*exp(-x(2)),2*x(1)*exp(-x(2));
        -2*(1-exp(-x(2))),1-2*x(1)*exp(-x(2))];
    
for i=1:nmax
    delta=df(x0)\f(x0);
    x1=x0-delta;
    if norm(x1-x0,inf)<1e-3
        x=x1;
        return;
    end
    x0=x1;
end
x=x1;
warning('Se ha alcanzado el numero maximo de iteraciones');