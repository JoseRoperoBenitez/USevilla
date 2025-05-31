function PContorno72est

a=.5; b =1; N=100;
ua=-1; ub=0;


p = @(x) 2./x;
q = @(x) 2./(x.*x);
f = @(x) zeros(size(x));

x = linspace (a,b,N);
x = x';
h = x(2) - a;
h2 =h.*h;

px=p(x);
qx=q(x);
fx=f(x);

A = diag (2+h2*qx) + diag (-1 + h*.5*px(1:end-1), 1) + ...
    diag (-1 - h*.5*px(2:end), -1);

b = h2*fx;

% Bloqueo Condiciones de Contorno

A(1,1)=1; A(1,2)=0; b(1)=ua;
A(N,N)=1; A(N,N-1)=0; b(N)=ub; % Dirichlet

%A(1,1)=-1, A(1,2)=1;b(1)=h*ua;A(N,N)=1;
%A(N,N-1)=-1;b(end)=h*ub; % Neumann

sol = A\b;
plot (x,sol)
