function PCauchyEulerest

f = @(t,y) 5*y;

% [tt,yy] = ode45 (f,[0,1], 1);

N = 100;
y0 = 1;

tt =linspace(0,1,N);
h = tt(2) - tt(1);

yy = zeros (size(tt));
yy(1) = y0;

for n =1:N-1
    yy(n+1)=yy(n) + h*f(tt(n), yy(n));
end
exacta =exp(5*tt);
close all

plot (tt,yy, 'ro-' ,tt,exacta, 'b*-')
legend ('aprox EULEr', 'exacta')
shg
