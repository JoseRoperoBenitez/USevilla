function Ejercicio11p3

% resolucion Ejercicio 11.3 de los apuntes de MATLAB

%datos
p=1.e-5;

%solucion exacta
exacta = @(t) t./sqrt(p+t.^2);

%valor frontera
yenb=exacta(0.1); %solo vemos uno pq la funcion es impar

%funcion segundo miembro del sistema
fun = @(t,z) [z(2); -3*p*z(1)./(p+t.^2).^2];

%condiciones de contorno
condcon = @(za,zb) [za(1) + yenb; zb(1)-yenb];

%aproximacion inicial
tinit=linspace(-0.1,0.1,10);
zinit=[0;1]; %pto medio es 0 pq la funcion es impar. 
            %el segundo numero me lo invento pq 0,0 suele dar problema

solinit=bvpinit(tinit,zinit);

% opciones 1
op1=bvpset('Stats','on');
fprintf('\n')
fprintf('Resol con valor standar de RelTol \n')

%resolvemos numericamente
sol1=bvp4c(fun,condcon,solinit,op1);

% opciones 2
op2=bvpset('Stats','on','RelTol',1.e-5);
fprintf('\n')
fprintf('Resolucion numerica con RelTol=%15.10f \n', bvpget(op2,'RelTol'))

%resolvemos numericamente
sol2=bvp4c(fun,condcon,solinit,op2);

% representacion grafica
close all
tt=linspace(-0.1,0.1);
yy1=deval(sol1,tt,1);
yy2=deval(sol2,tt,1);
yye= exacta(tt);

plot(tt,yy1,'b',tt,yy2,'r',tt,yye,'g*')

%zoom
axis([-0.04,0,-1,-0.6])
shg

