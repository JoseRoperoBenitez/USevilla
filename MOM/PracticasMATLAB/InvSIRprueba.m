function [beta, gamma] = InvSIRprueba(tobs,iobs,sobs,I0,R0,N,beta0,gamma0)
%
% enunciado...
%

%restricciones puntuales
ci=[0;0];
cs=[Inf;Inf];

%aprox inicial
bg0=[beta0;gamma0];

%fun a minimizar
funJ = @(bg) funaux(bg,tobs,iobs,sobs,I0,R0,N);

%opciones
op = optimset('TolFun',1e-15,'TolX',1e-15);
% resolucion al problema de minimos
[bgop, Costbgop] = fmincon(funJ,bg0,[],[],[],[],ci,cs,[],op);
beta =bgop(1);
gamma =bgop(2);

% resolucion en pantalla
fprintf('\n')
fprintf('--> Los valores calculados son: beta=%12.7f  y  gamma=%12.7f \n',bgop)
fprintf('--> Coste:%12.7f \n ',Costbgop)

%representacion grafica
T = tobs(end);
S0 = N-I0-R0;
y0= [S0;I0;R0];
fun= @(t,z) [-beta*z(1)*z(2); beta*z(1)*z(2)-gamma*z(2);gamma*z(2)];
sol = ode45(fun,[0,T],y0);

tt=linspace(0,T);
sop = deval(sol,tt,1);
iop = deval(sol,tt,2);
rop = deval(sol,tt,3);
plot(tt,sop,'r',tt,iop,'k',tt,rop,'b')
hold on

plot(tobs,iobs,'g.','MarkerSize',20)
plot(tobs,sobs,'y.','MarkerSize',20)

scal = deval(sol,tobs,1);
ical = deval(sol,tobs,2);
plot(tobs,scal,'go', tobs,ical,'ko')
legend('S ','I','R','iobs','sobs','s cal','i cal','Location','Best')


end

function val = funaux(bg,tobs,iobs,sobs,I0,R0,N)

%datos
T = tobs(end);
S0 = N-I0-R0;
y0= [S0;I0;R0];
b=bg(1);
g=bg(2);

fun= @(t,z) [-b*z(1)*z(2); b*z(1)*z(2)-g*z(2);g*z(2)];
sol = ode45(fun,[0,T],y0);
si = deval(sol,tobs,1);
ii = deval(sol,tobs,2);

val = sum (((si-sobs).^2) + ((ii-iobs).^2));


end



