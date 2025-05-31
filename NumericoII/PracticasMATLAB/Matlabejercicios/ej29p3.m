function ej29p3

f = @(x) cos(x).*cosh(x) + 1;
df = @(x) sinh(x).*cos(x) - sin(x).*cosh(x);
g = @(x) f(x) + x;

% Definimos los valores iniciales

x0 = 1;
epsilon = 1.e-10;
Nmax = 20;
% Comprobamos resultados:

disp ('MAS:')
disp (ASS2estudio(x0,Nmax,g,epsilon))

disp ('Newton:')
disp (Newtonestudio(f,df,x0,Nmax,epsilon))

disp('fzero:')
disp (fzero (f,[1,2]))