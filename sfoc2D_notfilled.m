function sfoc2D_notfilled(az,dip,rak)
% close all
%clear all
clf
set(gcf,'color','white')


if az==0;az=0.01;end
if az==90;az=90.01;end
if az==-90;az=-89.99;end
if az==-180;az=-179.99;end
if az==180;az=180.01;end
if az==270;az=270.01;end
if az==360;az=359.99;end
if dip==0;dip=0.01;end
if dip==90;dip=89.99;end
if rak==-180;rak=-179.99;end
if rak==0;rak=0.05;end
if rak==90;rak=89.99;end
if rak==-90;rak=-89.99;end
if rak==180;rak=179.99;end
% az
% dip
% rak


%tout en degres




t=linspace(0,360,200);
r=1;

x=r*cosd(t);
y=r*sind(t);

O=[0;0];
A=[r*cosd(90-az);r*sind(90-az)];
B=[r*cosd(-90-az);r*sind(-90-az)];
rdip=sqrt(2)*sind((90-dip)/2);
C=[rdip*cosd(-az);rdip*sind(-az)];



[O1,R1]=Ccirconscrit(A,B,C);
[x1,y1]=limarc(O1,A,B,300);


[S,Saz,Sdip]=slip(az,dip,rak);
if Sdip<0
    Sdip=-Sdip;
    Saz=Saz+180;
end
rSdip=sqrt(2)*sind((180/2-Sdip)/2);
D=[rSdip*cosd(180/2-Saz);rSdip*sind(180/2-Saz)];

E=[r*cosd(180/2-(Saz-180/2));r*sind(180/2-(Saz-180/2))];
F=[r*cosd(180/2-(Saz+180/2));r*sind(180/2-(Saz+180/2))];
rGdip=sqrt(2)*sind(Sdip/2);
G=[rGdip*cosd(180/2-(Saz+180));rGdip*sind(180/2-(Saz+180))];

[O2,R2]=Ccirconscrit(E,F,G);
[x2,y2]=limarc(O2,E,F,300);


[Pcart,Tcart,Ncart,Pfoc,Tfoc,Nfoc]=PTN(az*180/180,dip*180/180,rak*180/180);
Naz=Nfoc(1);
Ndip=Nfoc(2);
if Ndip<0
    Ndip=-Ndip;
    Naz=Naz+180;
end
rNdip=sqrt(2)*sind((180/2-Ndip)/2);
N=[rNdip*cosd(180/2-Naz);rNdip*sind(180/2-Naz)];

Paz=Pfoc(1);
Pdip=Pfoc(2);
if Pdip<0
    Pdip=-Pdip;
    Paz=Paz+180;
end
rPdip=sqrt(2)*sind((180/2-Pdip)/2);
P=[rPdip*cosd(180/2-Paz);rPdip*sind(180/2-Paz)];

Taz=Tfoc(1);
Tdip=Tfoc(2);
if Tdip<0
    Tdip=-Tdip;
    Taz=Taz+180;
end
rTdip=sqrt(2)*sind((180/2-Tdip)/2);
T=[rTdip*cosd(180/2-Taz);rTdip*sind(180/2-Taz)];


hold off
plot(x,y,'k')
axis square off
xlim([-1.2,1.2])
ylim([-1.2,1.2])
hold on
  plot(x1,y1,'k')
  plot(x2,y2,'k')


% plot(0,0,'k.')
% line([0,0],[-1.1,1.1],'color','k')
% line([-1.1,1.1],[0,0],'color','k')



 %coloriage de AEN
  [xAE,yAE]=limarc(O,A,E,300);
  [xEN,yEN]=limarc(O2,E,N,300);
  [xNA,yNA]=limarc(O1,N,A,300);
  xAEN=[xAE,xEN,xNA];
  yAEN=[yAE,yEN,yNA];

 %coloriage de NEB
%  [xNE,yNE]=limarc(O2,N,E,300);
  [xEB,yEB]=limarc(O,E,B,300);
  [xBN,yBN]=limarc(O1,B,N,300);
  xNEB=[xEN(length(xEN):-1:1),xEB,xBN];
  yNEB=[yEN(length(yEN):-1:1),yEB,yBN];

 %coloriage de BFN
  [xBF,yBF]=limarc(O,B,F,300);
  [xFN,yFN]=limarc(O2,F,N,300);
%  [xNB,yNB]=limarc(O1,N,B,300);
  xBFN=[xBF,xFN,xBN(length(xBN):-1:1)];
  yBFN=[yBF,yFN,yBN(length(yBN):-1:1)];

 %coloriage de AFN
  [xAF,yAF]=limarc(O,A,F,300);
  xAFN=[xAF,xFN,xNA];
  yAFN=[yAF,yFN,yNA];

 

 if ( rak<=0 | rak>=180 )%si P est dans AEN ou FBN
    cadran_color={'w','k'};%disp('cas 1')
 else
    cadran_color={'k','w'};     
 end   
 %fill(xAEN,yAEN,cadran_color{1})
 %hold on

 %fill(xNEB,yNEB,cadran_color{2})
 %fill(xBFN,yBFN,cadran_color{1})
 %fill(xAFN,yAFN,cadran_color{2}) 

%%affichage des points de construction
% plot(0,0,'k.');text(0,0,'O')
% plot(x,y,'k',x1,y1,'r',x2,y2,'b')
% plot(A(1),A(2),'r.');text(A(1),A(2),'A','color','r')
% plot(B(1),B(2),'r.');text(B(1),B(2),'B','color','r')
% plot(C(1),C(2),'r.');text(C(1),C(2),'C','color','r')
% plot(O1(1),O1(2),'r.');text(O1(1),O1(2),'O1','color','r')
% plot(O2(1),O2(2),'r.');text(O2(1),O2(2),'O2','color','r')
% plot(D(1),D(2),'r.');text(D(1),D(2),'D','color','r')
% plot(E(1),E(2),'r.');text(E(1),E(2),'E','color','r')
% plot(F(1),F(2),'r.');text(F(1),F(2),'F','color','r')
% plot(G(1),G(2),'r.');text(G(1),G(2),'G','color','r')
 plot(P(1),P(2),'r.');text(P(1),P(2),'P','color','r')
 plot(T(1),T(2),'r.');text(T(1),T(2),'T','color','r')
 plot(N(1),N(2),'r.');text(N(1),N(2),'N','color','r')
 axis equal off
 xlim([-1,1])
 ylim([-1 1])
 
 
















