%% Ejercicio4

% Duda: ¿Como almaceno la n con valor par >= 4?

n= 0;
n >= 2*n + 2;
% w5 = (0, 2, 2, . . . , 2, 2, 0)

w5 =[0,2*ones(1,n-2),0] ;

% w4= (2n, 2n − 2, . . . , 4, 2)

w4 = 2.*[n:-1:1]

% w6 = (1, 3, 5, . . . , n − 1, n, n − 2, . . . , 4, 2)

w6= [1:2:n-1,n:-2:2];

%% Ejercicio5


% No lo entiendo 

v = rand(10);

normaeuclidea = norm(v);

suma = sum(v);

productocosenos = prod (v);

media = mean(v);

mayorcomponente = max (v);

menorcomponente = min (v);

