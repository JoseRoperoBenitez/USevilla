function [x]=ejercicio1(A,b,x0,nmax)
x1=zeros(length(x0),1);
for i=1:nmax
    g=A*x0-b;
    erri=norm(g)^2;
    if erri<10^-6
        x=x1;
        return
    end
    d=(A*g)'*g;
    p=erri/d;
    x1=x0-p*g;
    x0=x1;
end
warning('Se ha alcanzado el numero maximo de iteraciones');
    
    
    