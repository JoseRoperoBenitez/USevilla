%% Ejercicio 8 y 9

%% a)

fa = @(x) x./(x.^2 + 1);
xa = linspace (-10,10);
plot (xa, fa(xa),"LineWidth",2) ;
axis equal
shg

%% b)
fb = @(x) cos (x.^2 -1);
xb = linspace (-10,10);
graficafb = plot (xb, fb(xb));
axis equal
shg

%% c) 
fc = @(x) x.*log(2 + x) ;
xc = linspace (-10,10);
plot (xc,fc(xc));
axis equal
shg


%% d)
fd = @(x) exp(-x) + x.^2 - x ;
xd = linspace (-5,10);
plot (xd, fd(xd));
axis equal
shg
 
%% e)
fe = @(x) ((sin(x./2)).^3)./ (cos(x./4));
xe = linspace (-10,10);
plot (xe,fe(xe));
shg


%% f)
ff = @(x) x.*(sin(x)).^2 ;
xf = linspace (-10,10);
plot (xf,ff(xf));
shg





