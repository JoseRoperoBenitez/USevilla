function ej3
%a
f=@(t,y) t*y.*sin(y)-y.^2;
[tt,yy]=ode45(f,[0 pi],1);
hold on;
plot(tt,yy);
shg;
%b
phi=@(t) spline(tt,yy,t);
%c
figure();
h=@(t) phi(t)-log(t+1)-1/2;
hold on;
plot(tt,h(tt));
plot([0 pi],[0 0]);
shg;
sol1=fzero(h,0.3);
sol2=fzero(h,2.7);

figure();
s=@(t) log(t+1)+1/2;
hold on;
plot(tt,phi(tt));
plot(tt,s(tt));
plot([sol1 sol2],[phi(sol1) phi(sol2)],'.r','MarkerSize',14);
fprintf('solucion1=%f y solucion2=%f',sol1,sol2);
shg;