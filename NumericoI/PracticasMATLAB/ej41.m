%% Ejercicio 41

% DUDA donde esta el plot raiz ?

f = @(x) x-1 + log(x.^2 + 1);
raiz = fzero (f, [0,1]);
x = linspace (0,1);
plot (x,f(x),'b')
hold on 
plot ([0,1],[0,0])
plot (raiz, f(raiz),'ko')
hold off
shg