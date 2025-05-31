function [u] = ProdAb(A,b,n)

% u = zeros(n,1);

% % for i = 1:n
%     for j = 1:n
%         u(i) = u(i) + A(i,j)*b(j);
%     end
% end

% Estudio

u = zeros (n,1);% vector de ceros

for i = 1:n
    for j = 1:n
        u(i) = u(i) + A(i,j)*b(j);
    end
end

