function Alle

%resolvemos el Problema 5 de la relacion (escribir en que consiste aqui)

% Datos
r=1.e-2;
a=100;
K=500;

%valores iniciales
N0=[50,100,150,200];

% funcion Alle

fun=@(t,y) r*y.*(y-a).*(1-y/K);

%resolvemos numericamente
[ts,Ns]=ode45(fun,[0,6],N0); %para cada col de Ns vamos a tener las sols para N0

%representamos graficamente
close all
plot(ts,Ns,'LineWidth',1.3) %te va a pintar las 4 graficas
 % si nos fijamos en la grafica nos da info

% Apartado 3 calculamos el tiempo que tarda en doblar la poblacion que
% inicialemnte tenia doscientos individuos
grid on

N4=@(t) interp1(ts,Ns(:,4),t)-400;
tc=fzero(N4,0.8);

%representacion grafica
hold on
plot([0,6],[400,400],'k')
plot(tc,400,'g*','MarkerSize',15)

legend('N0=50','N0=100','N0=150','N0=200','400','valor critico')

text(1.7,300,['El tiempo para doblar es: ',num2str(tc)])
