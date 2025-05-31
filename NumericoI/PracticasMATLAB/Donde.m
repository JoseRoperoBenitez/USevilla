function Donde (x,a,b)
%
% EJEMPLO CON USO DE ELSE IF
% Donde(x, a, b) escribe en la pantalla la ubicacion
% de x respecto del intervalo [a,b]:
% - si x < a
% - si a <= x < = b
% - si x > b
%
%
 if (x >= a) && (x<=b)
     disp (['el punto x=' , num2str(x), ' está en el intervalo',num2str(a),num2str(b)])
 elseif (x<a) 
      disp (['el punto x=' , num2str(x), ' está izq de intervalo',num2str(a),num2str(b)])
 else      
     disp (['el punto x=' , num2str(x), ' está der de intervalo',num2str(a),num2str(b)])
 end
end