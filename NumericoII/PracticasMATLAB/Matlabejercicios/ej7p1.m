function ej7p1

% Resolver mediante LU sistemas lineales. Comprobando que la sol es
% correcta.

%% a) 

Aa = [2, 1, -1; -1,0,1; 1,1,2];
ba = [1; 2; 9];

% Vamos a realizar lo siguiente: LUx = Pb de modo que vamos a ver los
% sistemas: -> Lz = Pb ; -> Ux = z

[L, U, P] = lu(Aa);
z = L\(P*ba);
xa = U\z;

disp ('APARTADO a): ')
disp (xa)

disp('Comprobamos el error: ')
disp (Aa*xa-ba)

%% b) 

Ab = [2,1,-1; 1,1,-3; 1,1,2];
bb = [-5; -9; 9];

[L, U, P] = lu (Ab);
z = L\ (P*bb);
xb = U\z;

disp ('APARTADO b): ')
disp (xb)

disp ('Comprobamos el error: ')
disp (Ab*xb - bb)

