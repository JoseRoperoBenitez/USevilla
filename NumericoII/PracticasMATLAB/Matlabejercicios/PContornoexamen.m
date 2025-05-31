function PContornoexamen (a,b,delta,ua,ub,N)

h = (b-a)/(N-1);
h2 = h.*h;
x = linspace (a,b,N);
x = x';

A = diag((1 + 2/h2)*ones(1,N)) + diag ((-1/h2 + x(1:end-1)/2*h),1) + ...
    diag ((-1/h2 - x(2:end)/2*h),-1);

d = linspace (ua,ub,N);
d= d';

% Condiciones de contorno:

A(1,1) = (1/h + delta); A(1,2) = (-1/h); d(1)= ua;
A(N,N) = (delta + 1/h); A(N,N-1) = (-1/h); d(N)= ub;

sol = (A\d);
disp (sol)

plot(x,sol)
shg

% PContornoexamen (0,1,10, -1, 0, 100)

