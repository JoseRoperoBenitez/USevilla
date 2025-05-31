function [x1,k] = masvec44(g,x0,Nmax,epsilon)

% Podemos resolver ejs 37-40 de problemas de teoria
for k =1:Nmax
    x1=g(x0);
    residuo = norm (x1-x0);
    if residuo < epsilon
        return
    end
    x0=x1;
end
warning('se ha llegado nmax iteraciones sin cumplirse test')