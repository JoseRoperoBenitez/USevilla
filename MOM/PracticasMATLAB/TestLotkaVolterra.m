function TestLotkaVolterra

tobs = [0.1,0.4,0.8,1.3,1.7,2.3];
 % u y v
u0=0.3; 
v0 = 0.4;

t0 = 0;
T = tobs(end);
y0 = [u0;v0];
fun = @(t,z) [5*z(1) - 3*z(1)*z(2); -z(2) + 2*z(1)*z(2)];

sol = ode45 (fun,[t0,T], y0);
yobs = deval(sol,tobs);

InvLotkaVolterra(tobs,yobs,u0,v0)