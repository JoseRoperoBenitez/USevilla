function [usol, vsol] = InvLotkaVolterra(tobs,yobs,u0,v0)
% resolvemos el problema inverso de Lotka-Volterra de determinar los datos 
% iniciales a partir de los valores observados.
% problema 26 relacion
% u' = 5u - 3uv
% v' = -v + 2uv
% u(0) = u0, v(0)=v0
%
% minJ(uo,vo) = sum (u(ti) - ui)^2

% datos
T = tobs(end);
uv0 =[u0;v0];

%cotas 
ci = [0;0];
cs = [Inf;Inf];

% funcional J
funJ = @(uv) funLotkaVolterra(uv,tobs,yobs,T);

%opciones
op = optimset('TolFun',1.e-15,'TolX',1.e-15);
% TolFun para que el valor del coste sea menor que esa (coste cerca)
% Tolx l distancia entre dos puntos es pequeña

[uv0op , Costuv0op] = fmincon (funJ,uv0,[],[],[],[],ci,cs,[],op);
usol=uv0op(1);
vsol=uv0op(2);

% representacion de resultados por pantalla
fprintf ('\n')
fprintf ('--> sol: datos iniciales u0 =%12.5f y v0=%12.5f \n',uv0op)
fprintf ('--> el valor del coste es: %20.17f',Costuv0op)

% representacion grafica
close all

sol = ode45(@funsdo,[0,T],uv0op);
u = @(t) deval(sol,t,1);
v = @(t) deval(sol,t,2);

tt = linspace(0,T);
plot (tt,u(tt), 'b',tt,v(tt),'r',tobs,yobs,'yo','MarkerSize',12)
legend ('u sol', ' v sol', 'datos observados')


end

% Funciones auxiliares, funcion coste
function val = funLotkaVolterra(uv,tobs,yobs,T)

% funcion coste a minimizar


sol = ode45 (@funsdo,[0,T], uv);
yti = deval(sol,tobs,1);
val = sum ((yti-yobs).^2);

end

%funcion del SDO
function dzdt = funsdo(~,z) % fun de t,z
 
% funcion del segundo miembro de la ecuacion
dzdt=[5*z(1)-3*z(1)*z(2);-z(2)+2*z(1)*z(2)]; % u=z1, v =z2

end

% InvLotkaVolterra([3.5,6.5,9],[0.566,0.464,0.9303],1.1,1.3)