function ejercicio2
%A=load('info.dat');
A=[20 5 8 3
    40 6 5 9
    35 8 4 12];
x=linspace(min(A(:,1)),max(A(:,1)));
polfall=interp1(A(:,1),A(:,2),x);
polcont=interp1(A(:,1),A(:,3),x);
polfall2=interp1(A(:,1),A(:,4),x);
hold on
plot(x,polfall,x,polcont,x,polfall2);
legend('Numero fallecidos','Numero contagiados 100000 habs','Numero fallecidos 100000 habs','Location','Best');
shg;

figure();
%c
coef=spline(A(:,1),A(:,2));
yy=ppval(coef,x);
hold on;
plot(x,yy);
plot(A(:,1),A(:,2),'r.','MarkerSize',15);
legend('Spline apartado c');
shg;

%d
fallaprox=@(t) ppval(coef,t);
a=fallaprox(500);
b=fallaprox(1000);
c=fallaprox(2000);
fprintf(['Para 500 habitantes hay aprox %f fallecidos, ' ...
    'para 1000 hay %f y para 2000 hay %f'],a,b,c);
