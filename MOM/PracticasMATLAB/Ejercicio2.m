function Ejercicio2
% esta fun resuelve el problema 2

% Apartado a)
% Leemos el fichero
x=load ('Finanzas.dat'); %para ver los datos mirarlo en current folder.
dias=1:length(x);

close all %cierro todas las ventanaas graficas
h=plot (dias,x, 'b');
shg

% Apartado b)
% Calculamos polinomio de Ajuste
da=1:80; %nos dice en 80 dias (dias de ajuste)
Aa=x(da);

% Grado 1
coef1 = polyfit(da,Aa,1);  %coeficientes de grado 2
p1 = @(x) polyval(coef1,x);

% Grado 2
coef2 = polyfit(da,Aa,2);
p2 = @(x) polyval(coef2,x);

% Grado 3
coef3 = polyfit(da,Aa,3);
p3 = @(x) polyval(coef3,x);

%representacion grafica de los pols.
hold on
% como grado 1 es mediante rectas lo dibujamos como los puntos inicial y
% final.
h1= plot([1,88],[p1(1),p1(88)],'g','LineWidth',1.7);

% No podemos hacer ahora lo mismo, hay que vectorizar
z=linspace(1,88,200);

p2z=p2(z);
h2= plot(z,p2z,'r','LineWidth',1.7);
p3z=p3(z);
h3= plot(z,p3z,'m','LineWidth',1.7);

xlabel('dias')
ylabel('valor de la accion')
title('Ajuste de precios')
legend([h1,h2,h3,h],"grado 1", "grado 2", "grado 3","datos",...
    'Location','Best')
axis([0,90,2.4e4,2.9e4]) %Cuidado con el axis como viene predeterminado

hold off
shg

% Error Cuadratico
% Se puede medir mediante la distancia de cada punto a la funcion que
% quiero aproximar. Esto es lo conocido como aprox de min cuadrados

% Calculamos los errores en la prediccion
dpre=81:88; %dias prediccion
Apre=x(dpre)'; %valores en dias de prediccion MUCHO OJO hay q trasponer

%MUCHO CUIDADO CON LAS DIMENSIONES

Vpre1=p1(dpre);
Vpre2=p2(dpre);
Vpre3=p3(dpre);

error1= norm(Vpre1-Apre);  %otra forma sqrt(sum(x.^2))
error2= norm(Vpre2-Apre); %Mucho cuidado pq tuvimos un fallo ya que si no trasponemos 
                          %tenemos un vector fila menos un vector columna
error3= norm(Vpre3-Apre);

text(20,2.55e4,['Error ajus. lineal: ', num2str(error1,'%7.2f')],'FontSize',12,'Color','g')
% Cuando ponemos el '%7.2f' decimos que nos de 7 caracteres y dos decimales
text(20,2.5e4,['Error ajus. cuadratico: ', num2str(error2,'%7.2f')],'FontSize',12,'Color','r')
text(20,2.45e4,['Error ajus. cubico: ', num2str(error3,'%7.2f')],'FontSize',12,'Color','m')