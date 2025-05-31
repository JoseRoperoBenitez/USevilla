function ej30p3

f = @(x) x + log(x./3);
df = @(x) 1 + 1./x;
g = @(x) f(x) + x;

% Definimos valores iniciales:

x0= 1;
epsilon = 10.e-10;
Nmax = 20;

disp ('MAS:')
disp (ASS2estudio(x0,Nmax,g,epsilon))

disp ('Newton:')
disp (Newtonestudio(f,df,x0,Nmax,epsilon))

disp('fzero:')
disp (fzero (f,1))