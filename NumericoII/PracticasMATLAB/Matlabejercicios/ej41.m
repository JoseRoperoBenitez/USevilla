function ej41

H = Fhilbert(4);
b1 = ones(4,1);
b2 = [0.905; 1; 1.2; 1.01];
b3 = [1; 0.9; 1; 1.1];
u0 = [0; 0; 0; 0];

disp('sol1:')
disp (H\b1)
disp ('sol1 Gauss-Seidel: ')
disp (relajacionestudio (H,b1,u0, 100, 10.e-6,1))

disp('sol2:')
disp (H\b2)
disp ('sol3 Gauss-Seidel: ')
disp (relajacionestudio (H,b2,u0, 100, 10.e-6,1))

disp('sol3:')
disp (H\b3)
disp ('sol3 Gauss-Seidel: ')
disp (relajacionestudio (H,b3,u0, 100, 10.e-6,1))
