function RoperoBenitez2

A = [5 -2 1
    -1 -7 3
    2 -1 8];
b = [3 2 1]';

% Calculamos el radio espectral de A:

recon = 2/(max (abs (eig(A))));

disp (['El método converge ya que abs(Eps) < 2/p(A)= ', num2str(recon)])

u0 = [0 0 0]';
Eps = 1.e-4;

[u,k] = MeIterativo (A,b,u0,Eps);

disp ('La sol por el método iterativo es: ')
disp (u)

disp ('La sol de Matlab es:')
B = (2*eye(3) + Eps*A);
disp (B\b)