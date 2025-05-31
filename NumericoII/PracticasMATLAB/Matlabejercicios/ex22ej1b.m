function ex22ej1b

% b)

A = [2 -1 0
    -1 2 -1
    0 -1 2];
b = [1,0,1]';

tau = .25;
u0 = [0,0,0]';
tol = 10.e-5;
nmax = 100;

[u,Iter] = Examen22ej1 (A,b,u0,tau,nmax,tol);

disp (u)
disp (Iter)

disp ('Sol Matlab: ')
disp (A\b)

% c)

radespA = max(eig(A));
taumax = 2/radespA;

disp (['El intervalo en cual se puede aplicar es: (', num2str(0), ',',...
    num2str(taumax), ')'])


