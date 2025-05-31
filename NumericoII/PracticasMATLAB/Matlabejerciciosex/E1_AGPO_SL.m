function E1_AGPO_SL
v=ones(10,1)*4;
v1=ones(9,1);
A=diag(v)+diag(v1,1)+diag(v1,-1);
b=1:10;
b=b';
x0=5*b;
nmax=25;
x=ejercicio1(A,b,x0,nmax);
disp(num2str(x));