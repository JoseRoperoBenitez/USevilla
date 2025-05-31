function ej2
A=[3 2
    5 7
    8 15];
coef=polyfit(A(:,1),A(:,2),length(A(:,1))-1);
z=linspace(min(A(:,1)),max(A(:,1)));
yy=polyval(coef,z);

yytrozos=interp1(A(:,1),A(:,2),z);

hold on;
plot(z,yy);
plot(z,yytrozos);
plot(A(:,1),A(:,2),'r.','MarkerSize',14);
legend('inter golbal','inter a trozos','pntos discretos');
shg;

p=@(x) interp1(A(:,1),A(:,2),x);

valor=integral(p,min(A(:,1)),max(A(:,1)))

%e
part=linspace(min(A(:,1)),max(A(:,1)),10),
xx=A(:,1);
h=part(2)-part(1);
valoraprx=h*sum((p(part(1:end-1))+p(part(2:end)))/2)

