function ej3(n)
f=@(t,y) y.^2-2*exp(t).*y + exp(2*t)+exp(t);
[tt,yy]=ode23(f,[0 5],1);

%b
h=@(t) interp1(tt,yy,t)-80.2;
plot(tt,h(tt));
yline(0);
sol802=fzero(h,4)
%c
t=linspace(0,5,n);
h=t(2);
y=zeros(n,1);
y(1)=1;
for k=1:n-1
    y(k+1)=y(k)+h*(y(k)^2-2*exp(t(k))*y(k)+exp(2*t(k))+exp(t(k)));
end
disp(num2str(y(n)));
figure();
hold on;
plot(tt,yy);
plot(t,y);
legend('solucion exacta','solucion esquema');
shg;
