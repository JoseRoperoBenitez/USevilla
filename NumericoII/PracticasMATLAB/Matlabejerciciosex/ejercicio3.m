function ejercicio3
%a
f=@(t,y) t.*cos(t)-sin(y.^2);
[tt,yy]=ode45(f,[0,10],0);

hold on
plot(tt,yy);


%b
z= linspace(0,10,10);
p=@(t) plot(t,interp1(tt,yy,t));
p(z);

y=@(t) 1/6.*t+1/3;
plot(z,y(z));
h=@(t) interp1(tt,yy,t)-y(t);
c1=fzero(h,6.6);
c2=fzero(h,8.8);
area=integral(h,c1,c2);
text(3,4,num2str(area));

shg;
