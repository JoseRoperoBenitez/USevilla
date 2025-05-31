function ej71est

f = @(t,y) (10*t - log(y+1))*.5;

close all
% Ode45

[tt,yy] = ode45 (f,[0,1], 1);

y15 = 1.5*ones(size(tt));
plot(tt,yy,'b', tt,y15,'k')

hold on

% f1 =@(t) interp1 (tt,yy,t);

finterp = @(t) interp1 (tt,yy,t) - 1.5;
sol = fzero (finterp,0.5);
disp (sol)

% plot(sol,finterp(sol),'.r','MarkerSize',10)

legend ('ode45', 'y=1.5', 'Location', 'Best')
shg