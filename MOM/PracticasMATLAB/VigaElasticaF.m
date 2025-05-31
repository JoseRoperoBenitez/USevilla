function VigaElasticaF(kappa,L,m,alpha,beta,f0,nforce)
%Ejercicio 16

%Resolvemos el sistema de optimalidad asociado a una viga elástica de
%rigidez k con desplazamiento en el extremo izquierdo amortiguado

%
%Argumentos de entrada:
%kappa: coeficiente de rigidez
%L: longitud de la viga
%m: factor de amortiguación en el extremo izquierdo
%alpha,beta: desplazamiento en los extremos
%f0, nforce: parametros de la fuerza f

%Parametros
unk=-1/kappa;
coefsin=nforce*pi/L;

%Función f
fsin=@(x) f0*sin(coefsin*x);

%Función del segundo miembro del SDO equivalente
fun= @(x ,z) [z(2); unk*fsin(x)];

%Condiciones de contorno
condcon=@(za,zb) [-kappa*za(2)+m*za(1)-alpha; zb(1)-beta];

%Aproximación inicial
xinit=linspace(0,L,10);
zinit=[(alpha+beta)/2;0];
solinit=bvpinit(xinit,zinit);

%Resolvemos numéricamente
sol=bvp4c(fun,condcon,solinit);

%Representación gráfica
close all
xx=linspace(0,L);
zz=deval(sol,xx,1);

plot(xx,zz,'b','LineWidth',3)
hold on
plot([0,L],[alpha,beta],'k','LineWidth',2)
hold off
legend('Viga deformada','Viga inicial')
xlabel('Longitud')
ylabel('Desplazamiento')

axis([0,L,-0.4,0.4])

shg

% >> VigaElasticaF(0.5, 1, 1, 0, 0, -0.2, 1)
% >> VigaElasticaF(0.5, 1, .2, 0, 0, -0.2, 1)
% >> VigaElasticaF(0.05, 1, .2, 0, 0, -0.2, 1)
% >> VigaElasticaF(0.15, 1, .2, 0, 0, -0.2, 1)
% >> VigaElasticaF(0.15, 1, .2, 0, 0, -0.2, 3)
