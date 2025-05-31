function ej61

M = load ('DatosSpline.dat');
close all % cerramos las graficas
n =length (M(:,1));
coef = polyfit(M(:,1),M(:,2),n-1);
z = linspace(min(M(:,1)),max(M(:,1)));
pz = polyval(coef,z);
pz2=spline(M(:,1),M(:,2),z);
plot(z,pz,z,pz2)
hold on; plot(M(:,1),M(:,2),'+r','MarkerSize','10')
legend('p.i.global','spline')
shg
