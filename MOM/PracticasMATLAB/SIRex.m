function [flag] = SIRex (beta,gamma,f,S0,I0,R0,T)
%
% Resolvemos el modelo SIR donde se supone que parte de los infectados no
% se recuperan y fallecen por la enfermedad;
% S' = -(beta/N)SI
% I' = (beta/N)SI-gammaI
% R' = gammafI
% Argumentos de entrada:
% beta:constante de infección
% gamma: constante de recuperación
% f: regula la cantidad de infectados que no se recuperan y fallecen
% S0: individuos susceptibles de contraer la enfermedad en el instante t=0
% S0: individuos infectados por la enfermedad en el instante t=0
% S0: individuos recuperados en el instante t=0
% T: tiempo de resolución

%datos
N = S0 + I0 + R0;
y0 = [S0;I0;R0];

%Segundo miembro de la ecuacion
fun = @(t,y) [-(beta/N).*y(1).*y(2); y(2).*(y(1)*(beta/N) - gamma);
    y(2)*gamma*f];
%Resol numerica
[ts,ys] = ode45(fun,[0,T], y0);

% Representacion grafica
close all
figure(1)
hold on
plot(ts,ys(:,1), 'LineWidth',1.3)
plot(ts,ys(:,2), 'LineWidth',1.3)
plot(ts,ys(:,3), 'LineWidth',1.3)
plot ([0,T], [N,N],'k--')
legend ('Susceptibles', 'Infectados','Recuperados','Poblacion Total')
axis([0,T,0,1.2*N])

% b) SI R0=beta/gamma el n√∫mero basico de reproducci√≥n. Si S0/N > 1/R0
% y S(T)/N(T) < 1/R0, existe T*>0 tal que I(t) es estrictamente creciente 
% en (0, T*), es estrictamente decreciente en (T*,inf) y alcanza su maximo, 
% I*.
% Calcular dicho T*, es decir tal que S(T*)/N(T*)=1/R0
% La variable de salida flag debe tomar true o false

r0 = beta/gamma;
n = length(ts);
st = ys(n,1);
if (S0/N > 1/r0) && (st/N < 1/r0)
    flag =true;
    [maxv,inf] = max(ys(:,2));
    tmax = ts(inf);
   hold on
    plot(tmax,maxv,'.b','MarkerSize',20)
    text(tmax,maxv,'Punto Máximo de I')
    hold off
else 
    flag = false;
    hold on
    text(0,0,'La enfermedad desparace para tiempos grandes')
end





% SIRex (0.001,0.007,3,120,30,0,365)