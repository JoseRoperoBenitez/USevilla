function Curvas

f = @(x) cos(x/pi);
g = @(x) ((log(x+3)).^2)./(x+2);
h = @(x) f(x) - g(x);
x = linspace (-10,30);
hold on 
plot(x,f(x),x,g(x),"LineWidth",5)

plot([-10,30],[0,0],'k')
plot([0,0],[-5,5],'k')

x1 = fzero(h,[0,5]);
x2 = fzero(h,[15,18]);
x3 = fzero(h,[20,25]);
disp(['Soluciones:', num2str(x1),',',num2str(x2),'y',num2str(x3)])
plot (x1,f(x1),'yo')
plot (x2,f(x2),'r.','MarkerSize',10)
plot (x3,f(x3),'co')

title ('Hola')
xlabel('eje x')
ylabel('eje y')
legend ('y = f(x)','y=g(x)')

shg
