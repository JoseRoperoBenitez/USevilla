function Autofun2(n,funcoef)
% ejercicio 22. igual que el 21 pero con funcoef en vez de la que teniamos
% antes

%  Autofun2(4,@(x) 2*cos(2*x)) lo hacemos y sale lo mismo q ej21.

% fun de segundo miembro del SDO equivalente
fun = @(x,z,lambda) [z(2);(funcoef(x)- lambda)*z(1)];

% cond de contorno
condcon = @(za,zb,lambda) [za(1);zb(1);za(2)-n]; %hay q poner una cond de contorno
%  adicional para el lambda. lo ajustamos para que tenga sol unica
% condcon = @(za,zb,~) [za(1);zb(1);za(2)-1] podemos poner tilde pq lambda
                                           % no apararece

% aprox inicial
xinit = linspace (0,pi,20);
zinit = @(x) [sin(n*x);n*cos(n*x)]; %z2 es la derivada de z1

initsol =bvpinit(xinit,zinit,n^2); %la aprox de lambda la ponemos con n^2

% opciones
op=bvpset('RelTol',1.e-3,'Stats','on');

%hay que ser finos y tener cuidado con este tipo de ejs, mirar los puntos
%por ejemplo para testear


% resolucion numerica
sol = bvp4c(fun,condcon,initsol,op);

% representacion grafica
xx = linspace (0,pi);
yy = deval(sol,xx,1); %pq buscamos la y
yy0 = zinit(xx); %una aproximacion de donde empezar a buscar
lambda = sol.parameters; % para recuperar el valor de lambda

close all;
plot (xx,yy,xx,yy0(1,:),'LineWidth',1.2)
leg1 = ['Autofuncion asociada a \lambda= ', num2str(lambda, '%9.5f')];
leg2 = 'Inicailizacion de Busqueda';
legend (leg1, leg2, 'Location','best')
axis([0,pi,-1,1])
grid on