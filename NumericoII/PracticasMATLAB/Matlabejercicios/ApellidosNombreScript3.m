function ApellidosNombreScript3
M=load('Datos.dat');
close all
% Apartado (a)
%figure(1)
t=M(:,1);
y=M(:,2);
coef=polyfit(t,log(y),1);
a=coef(1);
b=coef(2);
c= @(t) exp(b)*exp(a*t);
ct=c(t);
plot(t,ct)
shg
pause

%Apartado (b)
figure(1)
coef2=polyfit(t,y,2);
pz2=polyval(coef2,t);
fprintf('La parabola es y = %6.4f x^2 + %6.4f x+ %6.4f \n', ...
    coef2(1),coef2(2),coef2(3))
figure(1)
plot(t,pz2) %Para ver esta gráfica pulsa el espacio una vez vista la gráfica
% del apartado (a)
shg 
pause

%Apartado (c) Hay que volver a pulsar espacio.
if norm(ct-y)<norm(pz2-y)
    disp('c(t) tiene una mejor aproximación')
else disp('pz2 tiene una mejor aproximación')
end

%Apartado(d)
figure(2)
plot(t,ct,t,pz2)
hold on
plot(t,y,'.r','MarkerSize',15)
legend('curva exponencial','parábola','puntos fichero','Location','best')
shg
pause

%Apartado(e)
pz3= @(t) polyval(coef2,t);
h= @(t) c(t)-pz3(t);
habs=@(t) abs(h(t));
c1=fzero(h,0.5);
c2=fzero(h,3.45);
disp('El área de la región delimitada por la curva y la parábola es:')
disp(integral(habs,0,5))
disp('El área de la región delimitada por la curva y la parábola es con p.cortes:')
disp(-integral(h,0,c1)+integral(h,c1,c2)-integral(h,c2,5))