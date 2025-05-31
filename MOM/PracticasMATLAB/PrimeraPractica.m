% Vector:
v=[1,4,0];
w=[3;8;1];
v1=1:3:20;

v.*v; %Para hacer las operaciones componente a componente. Productos,
      % division y potencias.
v*w; %Producto escalar

% Para las m.funciones: 
% function [arg.salida] = nombre_fun(arg.entrada)

% Si hacemos sin(pi) en vez de salir 0 sale 1.22e-16 que es lo mismo para
% matlab.

% Para las funciones anonimas:
% x nombre_fun =@(variables) Expresion
%   Ejemplo: f=@(x)x.^2 (funcion vectorizada con el pto)
%    Cuando definimos una fun anonima con un parametro, si luego cambiamos
%   el paramtro saldra el mismo valor ya que el parametro se queda fijo al
%   primero puesto. Para hacer que cambie, ¡metemos param. en (variables)!

% Podemos crear fun anonima con varias expresiones de salida
g = @(x) [x.^2-1;-1-x;x+2];

g(1:7:18); % nos da una matriz como resultado.

% Si tenemos un pol p(x) =anx^n + ... + a1x + a0  Usamos polyval.

% p(x) = x^3 + 3x^2 -x + 4
coef = [1,3,-1,4];
pfun = @(x) polyval(coef,x);

% Cuando usamos operadores logicos nos va a devolver 0 o 1 logicos.
% Se pueden transformas boleanos en numeros

% Se puenden definir fun anonimas a trozos con boleanos

f=@(x)2*(x<0) + (cos(x)+1)*(x>=0);

% Coando find:

% Devuelve las componentes que verifican una condicion
find(v1>8);
v1>8;   % nos devuelve un vector de boolenaos.


