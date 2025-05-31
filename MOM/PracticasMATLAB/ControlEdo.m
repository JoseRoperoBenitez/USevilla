function ControlEdo(mu)
% Minimizamos el funcional J(v)=alpha/2*||y-yd|^2 + mu/2*|v| |
% sujeto a v en L^2(0,T)
% y solucion de la ecuacion de estado
% y' = a*y + v
% y(0) = y0
% Resolvemos el sistema de optimidad con estado adjunto
% -phi = a*phi + alpha*(y-yd)
% phi(T)=0
% v = -1/mu*phi

% datos (lo ponemos nosotros)
a=-0.5;
T=10;
y0=3;
alpha=2-mu;
unmu = 1/mu;

% calculo del estado deseado yd

vc = @(t) exp(-t); %nos fijamos en las dos ecuaciones y parece que el v=e^-t
fund = @(t,y) a*y+vc(t);

% resolvemos PC
solyd = ode45(fund,[0,T],y0);
yd = @(t) deval(solyd,t);

% ecuacion del SDO de optimalidad
funOP=@(t,z) [a*z(1)-unmu*z(2); -a*z(2)-alpha*(z(1) - yd(t))]% y =z (1), phi = z(2)

% condiciones de contorno
condcon  = @(za,zb) [za(1)-y0; zb(2)];

% aproximacion inicial
tinit = linspace (0,T,10);
zinit = [y0;0];
solinit = bvpinit (tinit,zinit);

% opciones de resolucion
op = bvpset ('Stats','on','RelTol',1.e-5); %ponemos un control mas fino

%resolvemos numericamente el problema de contorno
sol = bvp4c(funOP, condcon, solinit,op);

% representacion grafica
tt = linspace (0,T);
yy = deval (sol,tt,1); % la primera componente es la y
phi = deval (sol,tt,2); 
yyd = yd(tt);
vop = -unmu*phi; %control optimo
vcc = vc(tt); % el vc era el e^-t

subplot(1,2,1)
plot (tt,yy,'b', tt,yyd,'ro')
legend ('Estado optimo calculado', 'Estado deseado')

subplot (1,2,2)
plot (tt,vop, 'g', tt,vcc,'yo')
legend ('Control optimo calculado', 'Control si mu=0')

% ControlEdo(1)
% ControlEdo(0.01)
% ControlEdo(1.99)
% si jugamos con los valores de mu y alpha jugamos con el coste y lo que
% obtenemos
shg

