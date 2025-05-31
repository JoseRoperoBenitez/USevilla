function ex22ej3

% Apartado a)

M = load('Datos.dat');

t = M(:,1);
y = M(:,2);

plot (t,y,'.r','MarkerSize', 10) %Para ver los ptos


coef = polyfit (t,log(y),1); % Coef de la recta de regresion

%recta de regresion: y = coef(1)*t + coef(2)

a = coef(1);
b = coef(2);

c = @(t) exp(b).*exp(a*t);

ct = c(t);
hold on
plot (t,ct,'b')


% b)
% z = linspace (min(t),max(t));

coef2 = polyfit (t,y,2);
pglobal = polyval (coef2,t);

a2 = coef2(1);
b2 = coef2(2);
c2 = coef2(3);
disp (['La ec. de la parábola es: y = ', num2str(a2), 'x^2 + ',...
    num2str(b2),'x + ', num2str(c2)])

plot(t, pglobal,'c')

% c)

if norm(ct-y) < norm(pglobal-y)
    disp ('c(t) tiene mejor aprox')
else 
    disp ('pglobal tiene mejor aprox')
end

% d)

legend('ptos interpol', 'curva exponencial','pol segundo grado', ...
    'Location','Best')

% e)

pzval = @(t) polyval(coef2,t);

h = @(t) c(t) - pzval(t);

x1 = fzero (h,0);
x2 = fzero (h,3.5);

area = integral (h,x1,x2);
disp (['El area es: ', num2str(area)])
shg
