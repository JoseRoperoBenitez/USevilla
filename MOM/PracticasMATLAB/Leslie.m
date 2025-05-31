function Leslie(a,b,v0)

% Calculamos la distribucion del modelo de Leslie
% y estudiamos comportamiento a largo plazo.
% Datos de entrada:
% a: vector de n componentes (procreacion)
% b: vector de n-1 componentes (tasa de supervivencia)
% v0: vector de n componentes (distribucion inicial)

% Contruimos la matriz de Leslie
L = diag(b,-1);
L(1,:)= a;

% Podemos ir comprobando: Leslie([0,1,3,2],[.25,.5,.1],[100,70,70,40]')

% Calculamos autovalores y autovectores de L
[V,D ]=eig(L); % Nos devuelve V con los autovectores cada col asociada a  
              % un atoval y D una diag de los autovalores

% Caculamos el modulo de los autovalores y detectamos el modulo maximo
lambda=abs(diag(D));
[lgorro,Ind]=max(lambda); %vemos se verifica tma Perron
lgorro; %OJO menor q 1 sabemos lo que significa.
%el autoval de mod max es 0.8514

%calculamos autovector con componentes positivos y suma uno.

vv= V(:,Ind); % nos devuelve la columna Ind(1)
vv=abs(vv); % tomamos componentes positivas

norma1=norm(vv,1);
vv=vv/norma1; %sigue siendo autovector con compo pos y modulo 1
              %nos da la proporcion que hay - el 67% de la clase 1
              %                             - el 19% de la clase 2 ...
fprintf('Autovector normalizado: \n')
fprintf('%7.4f \n',vv')
fprintf('\n')
% Mostramos la distribucion de la especie durante los primeros 20 intantes
% de tiempo.

Niter = 20; %numero de interaciones
v=v0; %dato inicial
S=sum(v); %modulo de v
vn=v/S; % dato normalizado
fprintf('a')

%escribimos cabezera de una tabla

% fprintf('  k    vn1(k)    vn2(k)     vn3(k)      vn4(k)   \n')
% fprintf('----------------------------------------------- \n')
% fprintf(' %2i   %7.4f   %7.4f    %7.4f     %7.4f \n',0,vn)
% % %3i entero
% 
% for k=1:Niter
%     v=L*v;
%     S=sum(v); %modulo de v
%     vn=v/S; % dato normalizado
%     fprintf(' %2i   %7.4f   %7.4f    %7.4f     %7.4f  \n',k,vn) %k de la iteracion
% end

fprintf(['  k    vn1(k)    vn2(k)     vn3(k)      vn4(k)   |'...
    'v1(k)    v2(k)     v3(k)      v4(k) \n'])
fprintf(['------------------------------------------------'...
    '------------------------------------------------\n'])
fprintf([' %2i   %7.4f   %7.4f    %7.4f     %7.4f   |' ...
    ' %7.4f   %7.4f    %7.4f     %7.4f   \n'],0,vn,v)
% %3i entero

for k=1:Niter
    v=L*v;
    S=sum(v); %modulo de v
    vn=v/S; % dato normalizado
    fprintf([' %2i   %7.4f   %7.4f    %7.4f     %7.4f   |' ...
    ' %7.4f   %7.4f    %7.4f     %7.4f  \n'],k,vn,v) %k de la iteracion

    % OJO EN LA PARTE DE LA REPRESENTACION DE PANTALLA y en este caso
    % tenemos 4 %7.4f por las 4 cols de datos q buscamos.
end
