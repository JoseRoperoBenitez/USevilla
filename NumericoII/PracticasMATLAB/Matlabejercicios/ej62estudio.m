function ej62estudio

M = load('DatosSpline.dat');

x = M(:,1);
y = M(:,2);

% n= length(x);
% z = linspace (min(x), max(x)); NO HACE FALTA

coef = spline(x,y);

% a)

s = @(z) ppval(coef,z);

% b)
disp(['La integral pedida vale:', num2str(integral(s,0,40))])