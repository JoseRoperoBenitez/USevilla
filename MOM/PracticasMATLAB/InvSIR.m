function [beta, gamma] = InvSIR(tobs,iobs,sobs,I0,R0,N,beta0,gamma0)
% Segundo parcial grupo B
%
%tobs: vector que contiene los instantes de observacion, ti
%iobs, sobs: vectores que contienen los valores de infectados y suscept obs
%I0, R0; valores inic de infectados y recuperados
%N: poblacion total
%beta0, gamma0: aprox de gamm y beta
%

% Indicación para comprobar el programa:
% tobs = [10, 30, 80];
% iobs = [15.4075, 22.2595, 6.8395];
% sobs = [105.7308, 71.2347, 33.1868];
% I0 = 10; R0 = 0; N = 130; beta0 = 0.0015; gamma0 = 0.06;

% datos
T=tobs(end);
S0=N-I0-R0;
y0=[S0;I0;R0];

ci=[0;0];
cs=[Inf;Inf];
bg0=[beta0;gamma0];

%funcional a minimizar
funJ = @(bg) funaux(bg,tobs,iobs,sobs,I0,R0,N);
[bgop, Costbgop] = fmincon(funJ,bg0,[],[],[],[],ci,cs,[]);
beta = bgop(1);
gamma = bgop(2);

%representacion en pantalla
fprintf('\n')
fprintf('--> Los valores son beta=%12.7f y gamma=%12.7f \n',bgop)
fprintf('--> El valor del Coste es:%12.7f',Costbgop)

%representacion grafica (OJO)
odefun = @(t,z) [-beta*z(1)*z(2);beta*z(1)*z(2)-gamma*z(2);gamma*z(2)];
sol = ode45(odefun,[0,T],y0);
xx = linspace(0,T);
scal = deval(sol,tobs,1);
ical = deval(sol,tobs,2);
s = deval(sol,xx,1);
i = deval(sol,xx,2);
r = deval(sol,xx,3);

close all
hold on
plot(xx,s,'c', xx,i,'r', xx,r,'y')

plot(tobs,scal,'go', tobs,ical,'ko') %calculados en los tobs
plot(tobs,sobs,'g.', tobs,iobs,'k.') %observados en los tobs

legend('Suceptibles','Infectados','Recuperados','S calculado','I calculado', ...
    'S observado','I observado','Location','best');
text(20,10,[['\beta = ', num2str(beta)],['\gamma = ', num2str(gamma)]])
shg


end

function val = funaux(bg,tobs,iobs,sobs,I0,R0,N)

T=tobs(end);
S0=N-I0-R0;
y0=[S0;I0;R0];

beta = bg(1);
gamma = bg(2);
fun = @(~,z) [-beta*z(1)*z(2);beta*z(1)*z(2)-gamma*z(2);gamma*z(2)];
sol = ode45(fun,[0,T],y0);

iti = deval(sol,tobs,2);
sti = deval(sol,tobs,1);
val = sum((iti-iobs).^2 + (sti-sobs).^2);

end
