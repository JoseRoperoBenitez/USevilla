function [u1,n]= relajacion(A,b,u0,Nmax,Eps,w)
%function [u1,n]= relajacion(A,b,u0,Nmax,Eps,w)
m=length(b);
u1=zeros(m,1);
for n=1:Nmax
    for i=1:m
        u1(i)=u0(i)+w/A(i,i)*(b(i)-A(i,1:i-1)*u1(1:i-1)-A(i,i:end)*u0(i:end));
    end
    residuo=norm(u1-u0);
    if residuo < Eps
        return
    end
    u0=u1;
end
warning('fin de Nmax iteraciones sin cumplirse test de parada')