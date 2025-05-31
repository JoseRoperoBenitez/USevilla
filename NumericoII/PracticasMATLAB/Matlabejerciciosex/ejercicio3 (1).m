function ejercicio3(n)
f=@(t,y) -y.*cos(t);
[tt,yy]=ode23(f,[0,10],1);
hold on;
plot(tt,yy);
plot([0 10],[2 2]);
h=@(t) interp1(tt,yy,t)-2;
plot(tt,h(tt));
c1=fzero(h,3.9);
c2=fzero(h,5.5);
fprintf('los tiempos son %f y %f',c1,c2);
shg;
%c
figure();
t=linspace(0,10,n);
h=t(2);
ysol=zeros(n,1);
ysol(1)=1;
for k=1:n-1
    ysol(k+1)=ysol(k)*((2-h*cos(t(k)))/(2+h*cos(t(k+1))));
end
ysol
display(num2str(ysol(n)));
hold on;
plot(tt,yy);
plot(t,ysol);
legend('solucion exacta','esquema numérico');
shg;

    


