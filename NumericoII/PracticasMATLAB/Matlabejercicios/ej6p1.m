function ej6p1

%% a)

xa = linspace (1,2);
g6a = @(x) 3.^x + 2*x - 6;
h6a = @(x) sin((sqrt(x.^2 + 4*x))./(x.^3));

plot (xa,g6a (xa), xa, h6a (xa));
axis ([1,2,0,1.5]);
legend ('g(x)', 'h(x)');
shg;

%% b)

xb = linspace (1,2);
g6b = @(x) cos(x.^2 + 2*x + 1);
h6b = @(x) log ((sqrt(x+2))./(x.^3));

plot (xb, g6b (xb), xb, h6b (xb));
axis ([1,2,-1.5,2]);
legend ('g(x)', 'h(x)');
shg;

%% c)

xc = linspace (0,2);
g6c = @(x) (sin (pi*x))./(1+sqrt(2*x));
h6c = @(x) 5*exp(-2*x).*log(x.^2 + 1);

plot (xc,g6c (xc), xc, h6c(xc));
axis ([0,2,-0.5,1]);
legend ('g(x)', 'h(x)');
shg;

%% d) 

xd = linspace (-15,20);
f6d = @(x) log (x.^2 - 27);
g6d = @(x) ((x+10).*(x-10).*(18-x))/100;

plot (xd, f6d (xd), xd, g6d (xd));
axis ([-15,20,-20,15]);
legend ('f(x)', 'g(x)');
shg;





