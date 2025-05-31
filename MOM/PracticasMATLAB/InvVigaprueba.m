function [k,m]= InvVigaprueba(alpha,beta,xobs,uobs,k0,m0)
%
%
%

% restricciones puntuales
ci=[0.1;0.1];
cs=[Inf;Inf];

% aproximacion inicial
km0 = [k0;m0];

% funcion J a minimizar
funJ = @(km) funaux(km,alpha,beta,xobs,uobs);

%opciones
op=optimset('TolFun',1.e-15,'TolX',1.e-15);

% resolucion del problema de minimos
[kmop,Costkmop] = fmincon(funJ,km0,[],[],[],[],ci,cs,[],op);
k = kmop(1);
m = kmop(2);

% representacion en pantalla
fprintf('\n')
fprintf('--> valores calculados: k=%12.7f  y  m=%12.7f \n',kmop)
fprintf('--> Coste: %12.7f',Costkmop)

%representacion grafica
unk = 1/k;
fx = @(x) 5*sin(3*pi*x);
fun = @(x,z) [z(2);-unk*fx(x)];
condcon = @(za,zb) [-k*za(2)+m*za(1)-alpha; zb(1)-beta];
xinit = linspace(0,1,10);
zinit = [alpha;beta];
solinit = bvpinit(xinit,zinit);
sol=bvp4c(fun,condcon,solinit);
xx = linspace(0,1);
ui = deval(sol,xx,1);

close all
plot (xx,ui,'r')
hold on
plot(xobs,uobs,'k.','MarkerSize',20)
hold off
legend('Desplazamiento de la viga','Observaciones','Location','Best')
text(0.05,0.18,[['k=',num2str(k)],[' m=',num2str(m)]])
shg


end

function val = funaux(km,alpha,beta,xobs,uobs)
% resolvemos el problema de contorno

% datos
kc=km(1);
mc=km(2);
unk=1/kc;


%funcion x
fx = @(x) 5*sin(3*pi*x);

% funcion
fun = @(x,z) [z(2);-unk*fx(x)];

% condiciones de contorno
condcon = @(za,zb) [-kc*za(2)+mc*za(1)-alpha; zb(1)-beta];

% aproximacion inicial
xinit = linspace(0,1,10);
zinit = [alpha;beta];
solinit = bvpinit(xinit,zinit);

% resolucion problema de contorno
sol=bvp4c(fun,condcon,solinit);
ui = deval(sol,xobs,1);

val = sum((ui-uobs).^2);

end
% InvVigaprueba(0,0.2,[0,0.2,0.5],[0.2435,0.2883,0.1655],1.2,1.8)