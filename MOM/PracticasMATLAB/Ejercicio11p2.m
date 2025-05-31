function Ejercicio11p2

% resolvemos ejercicio 11p2 de los apuntes de matlab

% en primer lugar, hacemos cambio de variable

%funcion del segundo miembro del sistema

fun =@(x,z) [z(2);100*z(1)];

% condiciones de contorno
condcon = @(za,zb) [za(1)-1;zb(1)-2];

% aprox inicial
xinit = linspace (0,1,5);
zinit = [1.5;0]; % ponemos el pto medio de 1 y 2 y como z1'=z2 -> z2=0
solinit = bvpinit(xinit,zinit);

% resolucion numerica
sol = bvp4c(fun,condcon,solinit);

%representacion grafica
close all

xx = linspace(0,1); %es fila tb
% zz = deval(sol,xx);
% plot(xx,zz(1,:),'LineWidth',1.2) % de zz solo queremos el z1 que es el y1
                                 % el deval lo guarda por filas

% otra opcion
zz = deval(sol,xx,1);
plot(xx,zz,'LineWidth',1.2) 
shg