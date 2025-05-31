function [I]=ej1(fun,x)
I=sum((fun(x(1:end-1))+fun(x(2:end))).*(x(2:end)-x(1:end-1))/2);
area=integral(fun,1,10)