function [B] = InvRicatti(y0,A,Tfin,yobs,B0)
% resolvemos el problema inverso asociado al coeficiente B de la ec
% de Ricatti
% Argumentos de entrada
% y0: dato inicial del PC
% A: coeficiente de la ecuacion de Ricatti
% Tfin: tiempo final de resolucion
% yobs: valor final observado
% B0: aprox inicial de B

% restricciones puntuales
ci=0;
cs=Inf;

% funcion a minimizar
funJ = @(B) funRicatti(B,A,Tfin,y0,yobs);

%opciones para optimizacion
op=optimset('Display','off');
% resolvemos el problema de minimos
[Bop,CostBop] =fmincon(funJ,B0,[],[],[],[],ci,cs,[],op); % si CostBop 
                            % no es 0 no estamos resolviendo el pb inver

% Representacion
fprintf('\n')
fprintf('--> Solución: coef. B=%12.7f \n',Bop);
fprintf('--> Solucion: valor del coste=%12.7f \n', CostBop)

% resolvemos la ecuacion de Ricatti para Bop (el optimo ya calculado)

fun=@(t,y) exp(t).*cos(t) +A*y - Bop*y.^2;
[ts,ys] = ode45(fun,[0,Tfin],y0); 

% Representacion grafica

plot (ts,ys,'LineWidth',1.1,'COlor','r')
hold on
plot(0,y0,'k.','MarkerSize',20)
plot(Tfin,yobs,'y.','MarkerSize',30)
plot(Tfin,ys(end),'b.','MarkerSize',20)
hold off 
shg
end

% definimos la funcion asociada al coste

function val = funRicatti(B,A,Tfin,y0,yobs)
% funcion objetivo en el problema de minimos asociado al problema inverso
% de Ricatti
% valor del coste: val=|y(T) - yobs|^2

% resolvemos la edo de Ricatti
fun=@(t,y) exp(t).*cos(t) +A*y - B*y.^2;
[~,ys] = ode45(fun,[0,Tfin],y0); %no ponemos ts pq solo queremos ys
yTfin = ys(end);

%calculamos valor del coste
val= (yTfin - yobs)^2;

end

% >> InvRicatti(0.5,0.1,2.5,-2.838971,0.3)