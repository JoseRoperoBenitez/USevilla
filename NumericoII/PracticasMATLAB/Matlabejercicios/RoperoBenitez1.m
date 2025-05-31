function RoperoBenitez1

%b)

xa = linspace (0,2,11);
fa = @(x) exp(x.^2);

format long 
disp ('Valor por Simpson: ')
disp (F2Simpson(fa,xa))

disp ('Valor de la integral: ')
disp (integral(fa,0,2))