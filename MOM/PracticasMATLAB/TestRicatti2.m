function TestRicatti2
% funcion que genera datos para ejecutar Ricatti2

% Coeficientes a determinar
A=2;
B=2;

% ecuacion de Ricatti
fun = @(t,y) exp(-t).*cos(2*pi*t) + A*y - B*y.^2;

% datos
tobs = [0.1,0.4,0.8,1.3,1.7,2.3];

t0 = tobs(1);
Tfin = tobs(end);
y0=0.3;

% resolvemos numericamente
sol = ode45(fun,[t0,Tfin],y0);

% definimos yobs
yobs = deval(sol,tobs);

% aproximacion inicial
coefs0 = [1.5,1.6];

% ejecutamos Ricatti2
InvRicatti2 (tobs,yobs,coefs0)