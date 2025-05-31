function [x,Iter] = Newtonestudio (f,fp,x0,Nmax,epsilon)

% >> [x,Iter] = Newton (f,fp,x0,Nmax,epsilon)
% >> [x,Iter] = Newton (@(x) x+log(x/3), @(x) 1 + 1/x, 1, 100, 1e-2)

x = x0; % MUCHA ATENCION CON ESTO
for Iter = 1:Nmax
    fx=f(x);
    if abs (fx)<epsilon 
        Iter = Iter-1; % aqui no ha hecho ninguna iteración y por eso le 
                       % resta una iteración
        return 
    end
    dfx = fp(x); 
    if abs (dfx)<epsilon
      warning ('metodo interrumpido, derivada muy cercana a cero')
       return
    end
    res = fx/dfx;
    x = x-res;

   disp (['iter: ', num2str(Iter), ' valor aprox: ', num2str(x), ...
    '  valor del residuo: ', num2str(res)])

    if  abs(res)<epsilon % primera iteración
        return 
    end
end
warning ('num.max iteraciones completo sin test de parada.')

% Otra forma: 

% function [x,Iter] = Newton27 (f,fp,x0,Nmax,epsilon)
% 
% % >> [x,Iter] = Newton (f,fp,x0,Nmax,epsilon)
% % >> [x,Iter] = Newton27 (@(x) x+log(x/3), @(x) 1 + 1/x, 1, 100, 1e-2)
% 
% x = x0; % MUCHA ATENCION CON ESTO
% for Iter = 1:Nmax
%     fx=f(x);
%     if abs (fx)<epsilon 
%         Iter = Iter-1; % aqui no ha hecho ninguna iteración y por eso le 
%                        % resta una iteración
%         return
%     end
%     dfx = fp(x); 
%     if abs (dfx)<epsilon
%         warning ('metodo interrumpido, derivada muy cercana a cero')
%         return
%     end
%     res = fx/dfx;
%     x = x-res;
%     if  abs(res)<epsilon % primera iteración
%         return 
%     end
% end
% warning ('num.max iteraciones completo sin test de parada.')

