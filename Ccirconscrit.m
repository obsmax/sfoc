function [O,R]=Ccirconscrit(A,B,C)

%cherche le centre du cercle circonscrit au triangle ABC

%Ap=milieu de BC
%Bp=milieu de AC

Ap(1)=(B(1)+C(1))/2;
Ap(2)=(B(2)+C(2))/2;
Bp(1)=(A(1)+C(1))/2;
Bp(2)=(A(2)+C(2))/2;

a1=B(1)-Ap(1);
a2=B(2)-Ap(2);
a3=-(B(1)-Ap(1))*Ap(1)-(B(2)-Ap(2))*Ap(2);

b1=A(1)-Bp(1);
b2=A(2)-Bp(2);
b3=-(A(1)-Bp(1))*Bp(1)-(A(2)-Bp(2))*Bp(2);

O=inv([a1,a2;b1,b2])*[-a3;-b3];

R=sqrt(sum((B-O).^2));

end
