function [x] = Bajada (A,b)
% Bajada ([1 0 0; 2 3 0; 4 5 6], [1;2;1])

% n = length (b);
% x = zeros (size (b)); % Para dimensionar el vector x y mejorar la velocidad
%                       % del programa,
%                       % si no lo ponemos nos sale como un pequeño error
%                       % avisandonos.
% for i = 1:n
%     x(i)=(b(i) - A(i,1:i-1)*x(1:i-1))/A(i,i);
%     % z = 0;
%     % for j = 1:i-1
%     %  z = z+A(i,j)*x(j);
%     % end
%     % x(i)
% end
% disp ('comprobacion: ')
% disp (A*x-b)

% Para crear un ejemplo a mano no trivial usamos lo siguiente:

% A = rand (20);
% b = rand (20,1);
% A = tril (A)  triangular superior.
% Bajada (A,b)
% w = Bajada(A,b)


% Estudio

% n = length (b);
% x = zeros (size (b));
% 
% suma = 0;
% for i = 1:n
%     for j = 1:(i-1)
%         suma = suma + A(i,j)*x(j);
%     end
%     x(i) = (b(i) - suma)/A(i,i);
% end


% Otra forma:

n = length (b);
x = zeros (size (b));

for i = 1:n
    x(i) = (b(i)- A(i,1:x-1)*x(1:x-1))/A(i,i);
end

disp ('Comprobacion: ')
disp (A*x-b)

% A = rand (20);
% b = rand (20,1);
% A = tril (A)  triangular superior.
% Bajada (A,b)
% w = Bajada(A,b)


