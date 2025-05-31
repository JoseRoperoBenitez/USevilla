function [u1, Iter] = Jacobiestudio (A,b,u0,Nmax,Eps)


% diagA = diag(A);
% u=u0;
% 
% for Iter = 1:Nmax
%     res = (b-A*u0)./diagA;
%     u1 = u0 + res;
%     if norm(u1-u0) <Eps
%         return
%     end
%     u0=u1;
% end
% warning ('Número max de iteraciones alcanzadas.')
% 
% disp (u)
% 
% disp ('Comprobación del error: ')
% disp (u - (A\b))

% A = [5 -2 1
%     -1 -7 3
%     2 -1 8];
% b = [3
%     -2
%     1];

% Otra Forma

n = length(b);
% Comprobamos matriz es no singular.

for i = 1:n
    if abs(A(i,i)) < 1.e-6
        error ('La matriz es singular.')
    end
end

% Definimos las iteraciones

u1 = zeros (n,1); % vector col

for Iter = 1:Nmax
    for i = 1:n
        u1(i) = u0(i) + (b(i) - dot (A(i,:),u0(1:end))) / A(i,i);

        % dot es el producto escalar
        % (i,:) recorre todos los elementos de la columna.

    end
    if norm (u1-u0)< Eps 
        return
    end
    u0=u1;
end

% sol = A\b;
% disp ('Comprobación error: ')
% disp (u1 - sol)






