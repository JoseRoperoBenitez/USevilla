function y =ej24p2vec(x)

n = length (x);
y = zeros (size(x));

for i = 1:n
    if x(i) < 2
        y(i) = -x(i) + 2 ;
    else 
        y(i) = x(i) - 2 ;
    end
end
