function ej3p1

% Ejercicios 3,4
%% a)
x = linspace (-10,10);

f3a = @(x) sqrt ((1-x)./(1+x));
plot (x, f3a(x));

%% b)
x = linspace (-10,10);

f3b = @(x) x./log(x);
plot (x,f3b(x));

%% c) 
x = linspace (-10,10);

f3c = @(x) sqrt (1-x) + sqrt(x-2);
plot (x,f3c(x));

%% d) 
x = linspace (-10,10);

f3d = @(x) 3*ones(size(x));
plot (x,f3d(x));

%% e)
x = linspace (.5,10);

f3e = @(x) x.^(-1);
plot (x,f3e(x));

%% f)

x = linspace (3,10);

f3f = @(x) log(1./(x-2));
plot (x,f3f(x));

%% g)

x = linspace (-5,5);
r = 5*ones (size (x));
f3g = @(x,r) sqrt(r.^2 - x.^2);
plot (x,f3g(x,r));

%% h)
t = linspace (-10,10);
f3h = @(t) [(sin(4*t).^2); cos(5*t)];
y = f3h(t);
plot (t,y (1,:), t, y(2,:));
shg

