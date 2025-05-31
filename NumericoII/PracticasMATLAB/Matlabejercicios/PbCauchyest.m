function PbCauchyest (t0,tf,y0,N)


% Particion N puntos y N-1 subintervalos

N1 = N -1;
h = (tf - t0)/N1;
hmed = h*.5;
t = t0:h:tf;
t = t'; % Nodos en [a,b]

% Definimps valores iniciales

yheun = 0.*t; %Reserva de espacio
yheun(1) = y0; %Inicialización

yepm = 0.*t;
yepm(1) = y0;

yeuler = 0.*t;
yeuler(1) = y0;

for i = 1:N1

    yeuler(i+1) = yeuler(i) + h*f(t(i), yeuler(i));

    aux1 = yheun(i) + h*f(t(i), yheun(i));
    yheun(i+1) = yheun(i) + hmed*(f(t(i),yheun(i)) + f(t(i+1),aux1));

    aux2 = yepm(i) + hmed*f(t(i),yepm(i));
    yepm = yepm(i) + h*f((t(i) + t(i+1))/2, aux2);
end

figure
solext = sol(t);

plot (t,yeuler, t,yheun, t, yepm, t, solext)
hold on
legend ('Euler', 'Heun', 'Epm', 'Solexacta', 'Location', 'Best')

% Comparacion con ode45

[t,y45] = ode45 (@f, t, 1);
plot (t,y45)
legend ('Ode45')

shg





