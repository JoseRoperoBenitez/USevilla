function ej65

M = load('Finanzas.dat');

 
y = M(:,1);
x = 1:length(y); %días

plot(x,y,'.r','MarkerSize',5)

z = linspace (min(x), max(x));

coef1 = polyfit(x,y,1);
pz1 = polyval(coef1,z); % Recta de regresion

hold on
plot(z,pz1,'k', 'LineWidth',1.1)

disp (['La recta de regresión es: y= ',num2str(coef1(1)),'x + ', ...
    num2str(coef1(2))])
shg