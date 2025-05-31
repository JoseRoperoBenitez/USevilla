function B = InvRicatti2(tobs,yobs,coefs0)
% resolvemos el problema inverso asociado al coeficiente B de la ec
% de Ricatti2
% Argumentos de entrada
% tobs = tiempos de observacion
% yobs = valores observados
% coefs0 = aprox iniciales de A y B (dato inicial para buscar)

% restricciones puntuales
ci=[0;0]; %cota inferior
cs=[Inf;Inf]; %cota superior

% funcion a minimizar
funJ = @(AB) funRicatti2(AB(1),AB(2),tobs,yobs);

%opciones para optimizacion
op=optimset('Display','iter');

% resolucion numerica del problema de minimos
[ABop,CostABop] =fmincon(funJ,coefs0,[],[],[],[],ci,cs,[],op); % si CostBop 
                            % no es 0 no estamos resolviendo el pb inver

% Impresion por pantalla de los resultados
fprintf('\n')
fprintf('--> Los valores calculados son A=%12.7f y B=%12.7f \n',ABop);
fprintf('--> El valor del minimo es: =%12.7f \n', CostABop)

% resolvemos la ecuacion de Ricatti para ABop (el optimo ya calculado)

A = ABop(1);
B = ABop(2);
t0=tobs(1);
Tfin=tobs(end);
y0=yobs(1);

% resolvemos la edo de Ricatti
fun=@(t,y) exp(-t).*cos(2*pi*t) +A*y - B*y.^2;
sol= ode45(fun,[t0,Tfin],y0);

% Representacion grafica
tt=linspace(t0,Tfin);
yy=deval(sol,tt);

plot (tt,yy,'LineWidth',1.1,'COlor','r')
hold on
plot(tobs,yobs,'k.','MarkerSize',20)
hold off
shg
% en negro la sol y los puntos por lo que pasa
% lo que de verdad nos dice que hemos resuelto el pb inverso es que el
% coste es 0.0000.
end

% funcion para el minimizador
function val = funRicatti2(A,B,tobs,yobs)
% funcion coste para minimizar
% valor del coste: val=|y(t_i) - yi|^2

% datos
t0=tobs(1);
Tfin=tobs(end);
y0=yobs(1);

% resolvemos la edo de Ricatti
fun=@(t,y) exp(-t).*cos(2*pi*t) +A*y - B*y.^2;
sol= ode45(fun,[t0,Tfin],y0); %no ponemos ts pq solo queremos ys


%calculamos valor del coste
yti = deval(sol,tobs); %guardamos el valor de y en los ti
val= sum((yti - yobs).^2);

end

% Generacion de Datos