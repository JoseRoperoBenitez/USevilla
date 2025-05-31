function ej12p2

% %% Variante simple 
f = @(x) exp(-x.^2);
% x = linspace (0,1,16);
% h = x(2)-x(1); % también se puede usar h = 1/15, h = (b-a)/n
% fx = f(x);
% sol = h*sum(fx(1:end-1));
% disp ('Aprox de la integral usando form. rect izq')
% disp (sol)
% disp ('Aproximación con comando integral de Matlab')
% disp (integral (f,0,1))
% 
% %% Variante con los nodos NO necesariamente equiespaciados
% 
% f = @(x) exp(-x.^2);
% x = linspace (0,1,16);
% fx = f(x);
% z = fx(1:end-1).*(x(2:end) - x(1:end-1));
% sol = sum (z);
% disp ('Aprox de la integral usando form. rect izq')
% disp (sol)
% disp ('Aproximación con comando integral de Matlab')
% disp (integral (f,0,1))
% 
% % z = fx(1:end-1).*(x(2:end)-x(1:end-1));
% sum (z)


% Estudio

x = linspace (0,1,16);
fx = f(x);
h = x(2) - x(1);
sol = h*sum (fx(1:end-1));
% z = fx(1:end-1).*(x(2:end) - x(1:end-1));
% sol = sum (z);
disp ('El valor por Frect: ' )
disp (sol)
disp ('El valor de la integral es: ')
disp (integral (f,0,1))

