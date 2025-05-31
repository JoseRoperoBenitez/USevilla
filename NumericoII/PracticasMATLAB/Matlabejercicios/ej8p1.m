function ej8p1

% Resolver mediante Cholesky los sistemas lineales: 

%% a)

Aa = [1,-1,1; -1,5,1; 1,1,3];
ba = [1;1;0];

% Vamos a realizar lo siguiente: Cholesky (BB' = A) consiste en BB'x = b 
% (B'=B^t) , por esta razón vamos a resolver: -> Bz = b  y  -> B'x = z

Ba = chol (Aa, 'lower');
z = Ba\ ba;
xa = Ba'\ z;

disp ('APARTADO a): ')
disp (xa)

disp ('Comprobamos el error: ')
disp (Aa*ba - xa)

%% b)

Ab = [1,2,-1,0 ; 2,5,1,1; -1,1,14,5; 0,1,5,3];
bb = [2; 6; 6; 2];

% BB'x = b

Bb = chol(Ab, 'lower');
z = Bb\bb;
xb = Bb'\z;

disp ('APARTADO b): ')
disp (xb)

disp ('Comprobación del error: ')
disp (Ab*xb - bb)