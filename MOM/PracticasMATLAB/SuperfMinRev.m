function SuperfMinRev(A, B)

%Practica Ejercicio 13

%datos
a = A(1);
b = B(1);
al =A(2);
be =B(2);

% funcion del segundo miembro del sistema (tras cambio de variable)
fun = @(x,z) [z(2); (1 + z(2).^2)./z(1)];

% condicion de contorno
condicion = @(za,zb) [za(1)-al;zb(1)-be];

%aprox inicial
xinit =linspace(a,b,10);
zinit=[al,0];
solinit=bvpinit(xinit,zinit);

%opciones
op = bvpset('Stats','on','Nmax',2000);

%resolvemos numericamente
sol=bvp4c(fun,condicion,solinit,op);

%representamos graficamente
close all
xx=linspace(a,b);
uu=deval(sol,xx); % el 1 por la primera compontente, q es la fun y.

plot(xx,uu(1,:),'LineWidth',1.2)

% Identidad de Beltrami
figure;
u = uu(1,:);
up= uu(2,:); %u prima
Beltrami = u.*up.^2./sqrt(1+up.^2) - u.*sqrt(1+up.^2);
plot(xx,Beltrami,'LineWidth',1.2) %sale los ejes con el error orden 1e.-5
axis([a,b,1.1*min(Beltrami),0]) 