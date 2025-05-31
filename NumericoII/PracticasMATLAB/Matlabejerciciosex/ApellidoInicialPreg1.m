function [valor]=ApellidoInicialPreg1(x,y)
tam=length(x);
contencima=0;
contabajo=0;
for i=1:tam
    if y(i)<x(i)^2-1 && y(i)>0
        contabajo=contabajo+1;
    elseif y(i)>x(i)^2-1 && y(i)<0
        contencima=contencima+1;
    elseif y(i)==x(i)^2-1 || y(i)==0
        valor=3;
        return
    end
end
if contencima==tam
    valor=1;
elseif contabajo==tam
    valor=2;
else
    valor=4;
end

        