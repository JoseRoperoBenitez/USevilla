function [k,m] = InvViga(alpha,beta,xobs,uobs,k0,m0)
% Problema 2ºparcial grupoC
% 
% vamos a resolver un problema de minimos cuadrados para minimizar el coste
% de unos valores concretos de un problema de contorno
% datos de entrada:
% alpha, beta: datos de las condcon
% xobs: vector con los puntos de observacion xi
% uobs: vector con los valores de datos observados
% k0,m0: valores de aprox iniciales de k y m

% restricciones puntuales
ci= [0.1;0.1];
cs = [Inf;Inf];

% aprox inicial
km0 = [k0;m0];

% funcion a minimizar
funJ = @(km) funaux (km, alpha,beta,xobs,uobs);

% opciones 
op = optimset('TolFun',1.e-15,'TolX',1.e-15);

% resolucion numerica del problema de minimos
[kmop, Costkmop] = fmincon(funJ,km0,[],[],[],[],ci,cs,[],op);
k = kmop(1);
m = kmop(2);

%representacion en pantalla
fprintf('\n')
fprintf('--> los valores calculados son k=%12.7f y m=%12.7f \n',kmop)
fprintf('--> El valor del coste es: %12.7f \n',Costkmop)

% representacion grafica
% antes resolveos el Pco para nuestros k y m optimos

unk = 1/k;
funx = @(t) 5*sin(3*pi*t);
funpc = @(x,z) [z(2);-unk*funx(x)];
condcon = @(za,zb) [-k*za(2)+m*za(1)-alpha; zb(1)-beta];
xinit = linspace(0,1,10);
uinit = [alpha;beta];
solinit = bvpinit(xinit,uinit);
sol = bvp4c(funpc,condcon,solinit);


xx = linspace (0,1);
uop = deval (sol,xx,1); %u(x)
close all 
plot (xx,uop, 'r')
hold on
plot (xobs,uobs,'k.','MarKerSize',12)
legend ('Desplazamiento de la viga','Valores observados','Location','Best')
text(0.05,0.18,[['k=', num2str(k)],[' m=',num2str(m)]])
shg


end

function val = funaux (km, alpha,beta,xobs,uobs)
% tenemos que resolver a continuacion un pb de contorno

%datos 
ki = km(1);
unk = 1/ki;
mi = km(2);

%funcionx
funx = @(x) 5*sin(3*pi*x);

% funcion principal
funpc = @(x,z) [z(2);-unk*funx(x)];

%condiciones de contorno
condcon = @(za,zb) [-ki*za(2)+mi*za(1)-alpha; zb(1)-beta];

%aprox inicial
xinit = linspace(0,1,10);
uinit = [alpha;beta];
solinit = bvpinit(xinit,uinit);


% resolvemos
sol = bvp4c(funpc,condcon,solinit);
ui = deval(sol,xobs,1);

val = sum ((ui-uobs).^2);

end

% InvViga(0,0.2,[0,0.2,0.5],[0.2435,0.2883,0.1655],1.2,1.8)


