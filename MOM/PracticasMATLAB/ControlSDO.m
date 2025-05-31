function ControlSDO(mu)
%
% Resolvemos el sistema de optimalidad del problema de control
% min J(v) = alpha/2* | |y-yd| |^2+mu/2*|v||^2
% sujeto a: (y,v) sol de 
% y1' = A*y1 + B*y2+ v en (0,T)
% y2' = C*y1+D*y2
%y1(0) = y01, y2(0)=y02

%datos
alpha = 2 -mu;
unmu = 1/mu;
A = -0.05;
B = 0.03;
C = -0.11;
D = 0.115;
M = [A,B;C,D];

%Q = [1;0];

%T = 20; %inventado (tiempo final)
T = 25*pi; % para que la grafica salga bien por posibles cosas problemas con v

% datos iniciales 
y01=1;
y02=1.5;
y0= [y01;y02];

% control test
vtest = @(t) 0.1*cos(-t/50);

%funcion del segundo miembro del SDO para yd
fyd = @(t,y) M*y+[vtest(t);0];

%calculamos numericamennte yd
sold=ode45(fyd,[0,T],y0);

yd1= @(t) deval (sold,t,1);
yd2= @(t) deval (sold,t,2);

% sistema de optimalidad
Mopt = [M, zeros(2,2); -alpha*eye(2), -M'];
Mopt(1,3) = -unmu;

%termino indep
Tind= @(t) [0;0;alpha*yd1(t); alpha*yd2(t)];

% funcion del segundo miembro del sdo de optimalidad

fun = @(t,z) Mopt*z + Tind(t);

% condiciones de contorno
condcon = @(za,zb) [za(1)-y01; za(2)-y02; zb(3); zb(4)];

%aprox inicial
tinit = linspace(0,T,10);
zinit = [y0;0;0]; %y0 es y01, y02
solinit = bvpinit (tinit,zinit);

% opciones de resolucion
op = bvpset ('Stats','on','RelTol',1.e-5);

% resolvemos numericamente el PCo
sol = bvp4c(fun,condcon,solinit,op);

% representacion grafica
tt = linspace (0,T);
yy = deval (sol,tt); % tenemos aqui las 4 componentes, y1,y2,phi1,phi2

subplot(1,2,1)
plot (tt,yy(1,:), 'b', tt,yy(2,:),'g')
hold on
plot (tt,yd1(tt), 'bo', tt,yd2(tt),'go')
hold off
legend ('Estado calculado 1','Estado calculado 2', 'Estado deseado 1', ...
    'Estado deseado 2','Location','Best')

subplot (1,2,2)
vc = -unmu*yy(3,:);      %v calculado
plot (tt,vc,'r' , tt, vtest(tt),'yo')
legend ('Control optimo', ['Control si \mu = 0'])
shg

% Lo que pasa en la segunda grafica es pq v pertenece a L^2, cjto de medida
% nula