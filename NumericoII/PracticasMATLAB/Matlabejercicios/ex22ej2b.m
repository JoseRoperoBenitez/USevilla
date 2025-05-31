function ex22ej2b

f = @(x,y) [x^3 - 5*x^2 + 4*x - y^2;...
    x + log(x) - y];
df = @(x,y) [3*x.^2 - 10*x, -2*y;...
    1+1/x, -1];
x0 = 6;
y0 = 8;
Eps = 1.e-4;
Nmax = 100;

Whittakerex22 (f,df,x0,y0,Eps,Nmax)