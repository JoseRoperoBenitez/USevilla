function ej62

M = load ('DatosSpline.dat');
close all % cerramos las graficas
n =length (M(:,1));
coef = spline(M(:,1),M(:,2));

%a)
s = @(z) ppval(coef,z); % def de la funcion spline

% b)
disp(['La integral pedida vale:', num2str(integral(s,0,40))])

