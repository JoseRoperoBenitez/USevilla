function VigaElasticaNH2(kcero, L, alpha, beta, f0, nforce, h)
%Ejercicio 17

%Resolvemos el sistema de optimalidad asociado a una viga elástica de
%rigidez k(x)=1+kcero*x^2

%Argumentos de entrada:
%kcero:      coeficiente de rigidez no homegenea
%L:          longitud de la viga
%alpha,beta: desplazamiento en los extremos
%f0, nforce: parametros de la fuerza f
%h:          coeficiente de amortiguación

%Parametros
coefsin=nforce*pi/L;
h2=0.5*h;
h4=0.25*h;

%Función f
fsin=@(x) f0*sin(coefsin*x);

%Función de rigidez
unk=@(x) 1./(1+kcero*x.^2);

%Función del segundo miembro del SDO equivalente
fun= @(x ,z) [z(2)*unk(x); h*z(1)-fsin(x)];
fun2= @(x ,z) [z(2)*unk(x); h2*z(1)-fsin(x)];
fun4= @(x ,z) [z(2)*unk(x); h4*z(1)-fsin(x)];

%Condiciones de contorno
condcon=@(za,zb) [za(1)-alpha; zb(1)-beta];

%Aproximación inicial
xinit=linspace(0,L,10);
zinit=[(alpha+beta)/2;0];
solinit=bvpinit(xinit,zinit);

%Resolvemos numéricamente
sol=bvp4c(fun,condcon,solinit);
sol2=bvp4c(fun2,condcon,solinit);
sol4=bvp4c(fun4,condcon,solinit);

%Representación gráfica
close all
xx=linspace(0,L);
zz=deval(sol,xx,1);
zz2=deval(sol2,xx,1);
zz4=deval(sol4,xx,1);

hold on
plot([0,L],[alpha,beta],'k','LineWidth',2)
plot(xx,zz,'b','LineWidth',3)
plot(xx,zz2,'r','LineWidth',3)
plot(xx,zz4,'g','LineWidth',3)
hold off
legend('Viga inicial','Viga deformada h','Viga deformada h/2', ...
    'Viga deformada h/4','Location','best')
xlabel('Longitud')
ylabel('Desplazamiento')

shg

% >> VigaElasticaNH(10,1,0,0,-5,2,10)