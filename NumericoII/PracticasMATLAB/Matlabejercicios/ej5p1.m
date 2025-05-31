function ej5p1

% a)

xa = linspace (-1.5,1.5);
f5a = @(x) 2*(sin(x).^3).*(cos(x).^2);
g5a = @(x) exp(x)-2.*x-3;
plot (xa,f5a(xa),'b', xa,g5a(xa),'r');

% b)

xb = linspace (0,5);
f5b = @(x) log(1+x) - x;
g5b = @(x) 2-5*x;
plot (xb,f5b(xb),'y', xb, g5b(xb),'g');

% c) 

xc = linspace (-pi/2,pi/2);
f5c = @(x) 6*sin(x);
g5c = @(x) 6*x - x.^3;
plot (xc, f5c(xc),'k',xc , g5c (xc), 'r');

% d) 

xd = linspace(-1,2);
f5d = @(x) exp(-x.^2 + 2).*sin(x/2);
g5d = @(x) -x.^3 +2*x + 2;
plot (xd, f5d(xd),'r', xd, g5d(xd),'g');

% e) 

xe1 = linspace (-1,1);
xe4 = linspace (-4,4);
re1 = 1*ones (size(xe1));
re4 = 4*ones (size (xe4));
f5e = @(x,r) (sqrt (r.^2 - x.^2));
plot (xe1, f5e(xe1,re1),'k',xe4, f5e(xe4,re4),'b')



