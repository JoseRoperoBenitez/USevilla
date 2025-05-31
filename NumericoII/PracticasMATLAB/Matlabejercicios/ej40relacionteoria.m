function ej40relacionteoria

g = @(x,y) x.^2 + y.^2;
x0 = [0;0];
Nmax = 50;
Eps = 10.e-6;

disp (AASSvectorizadoest (g,x0,Nmax,Eps))

%AASSvectorizadoest (@(x) -log(x/3),1,100, 1e-4)