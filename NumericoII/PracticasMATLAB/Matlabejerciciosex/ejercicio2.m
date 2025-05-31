function ejercicio2

%a
%A=Load('Medidas.dat');
A=[5 2 1
   10 3 6
   15 9 7];
%b
z=linspace(5,15,10);
valores=interp1(A(:,1),A(:,2),z);
y0=interp1(A(:,1),A(:,2),9.5)
hold on
plot(z,valores);
plot(9.5,y0,'.r');
hold off;
shg;

figure();
%c
hold on;
coef=polyfit(A(:,2),A(:,3),1);
yy=polyval(coef,z);
plot(z,yy);
plot(z,yy,'.r','MarkerSize',14);
shg;

%d
t0=min(A(:,1));
tf=max(A(:,1));
s=@(x) spline(A(:,1),A(:,3),x);
disp(num2str(integral(s,t0,tf)));


