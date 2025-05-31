%% Ejercicio 15

%% a)

x = @(t) sin(2*t);
y = @(t) sin(3*t);
t = linspace (0,2*pi);
plot (t,x(t), 'r', t,y(t),'k')
axis equal
shg

%% b)

xb = @ (t) 3*cos(t) - cos (3.*t);
yb = @ (t) (4*sin(t)).^3;
tb = linspace (0,2*pi);
plot (tb,xb(tb),'g', tb, yb(tb))


shg

%% Ejercicio 16

f = @(x) x.^2 +2;
x = linspace (-2,2);
hold on
plot (x,f(x),"LineWidth",5)

plot([-1,1],[0,0],'k')
plot([0,0],[-1,4],'k')

axis ([-1,1 , -1,4])
hold off
shg

