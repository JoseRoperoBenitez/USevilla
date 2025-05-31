%% Ejercicio 38 (mejor hecho en Ejclase2)
%a
Aa = [2,-3,0,1; -5,1,1,-1; 2,-1,-1,1; 0,1,-1,0];
ba = [1,0,2,3];
ba = ba' ;
xa = Aa\ba ;

%b 

Ab = [1,-1,8,-1; -1,2,1,-2; 0,2,6,-1; 1,1,-1,-1];
bb = [1,1,0,5];
bb= bb' ;
xb = Ab\bb;

%c (Sale SCIndeterminado) x = NaN,NaN,NaN

Ac = [1,1,-1; -1,1,1; 1,3,-1];
bc = [3,2,8];
bc = bc';
xc = Ac\bc;

%d 

Ad = [1,-1,1; -1,5,1; 1,1,3];
bd = [1,1,0];
bd = bd';
xd = Ad\bd ;

%e

Ae = [0,2,0,4; 2,2,3,2; 4,-3,0,1; 6,1,-1,-5];
be = [0,-2,-7,6];
be = be';
xe = Ae \ be;

%f (Sale S.Incompatible) Sols: NaN,Nan,-Inf,-Inf.

Af = [2,2,0,1; 2,-2,1,0; 1,0,-1,1; -4,4,-2,0];
bf = [1,-2,0,1];
bf = bf';
xf = Af\bf;




