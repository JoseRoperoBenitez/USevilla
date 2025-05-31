function [h] = InvSatelite(tobs,robs,rho00,rho10,h0)

% Vamos a resolver el problema inverso con los datos de entrada:
% tobs: vector tiempo observado
% robs: vector de valores de rho observado
% condiciones iniciales: rho00, rho10
% h0: aprox inicial de h

% Datos de resolución
% tobs = [3000, 9000, 12000, 15000, 18000]
% robs = [17831, 35335, 40754, 44614, 47133]
% rho00 = 6578 
% rho10 = 0 
% h0 = 50000

% datos
GM = 398440;
ci= 0;
cs= Inf;
r0 = [rho00;rho10];
T = tobs(end);

funJ = @(h) fun(h,tobs,robs,rho00,rho10);
op = optimset( 'Display', 'iter','TolFun',1.e-9,'TolX',1.e-9);
[hop,Costh] = fmincon(funJ,h0,[],[],[],[],ci,cs,[],op); %ho es la aprox inic
% OJO CON EL h0

%Imprimimos sol
fprintf ('\n')
fprintf ('--> Coeficiente de h calculado:%12.7f \n',hop)
fprintf ('--> Valor del coste: %12.7f \n', Costh)

%Calculamos numericamente
f = @(t,z)[z(2);hop^2/z(1)^3-GM/z(1)^2];
sol1 = ode45(f,[0,T],r0);
tt = linspace(0,T);
xx = deval(sol1,tt,1);
rcal = deval(sol1,tobs,1);
close all
plot(tt,xx,'LineWidth',1.5)
hold on
plot(tobs,rcal,'g.','MarkerSize', 30)
plot(tobs,robs,'r.','MarkerSize',20)
legend('Soluciones de rho','Valores calculados','Valores aproximados','Location','best')
shg

end

function val = fun(h,tobs,robs,rho00,rho10)

% Función que minimiza J(h) = sum|rho(ti)-rhoi|^2 , i=1,..,n, 
% sujeto a h, rho''= h^2/rho^3 - GM/rho^2

GM = 398440;
r0 = [rho00;rho10];
T = tobs(end);
fun = @(t,z)[z(2);h^2/z(1)^3-GM/z(1)^2]; % la ponemos de aqui pq dep de h
sol = ode45(fun,[0,T],r0);
ri = deval (sol,tobs,1);

val = sum ((ri-robs).^2);

end




