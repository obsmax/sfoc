function sfoc3D(az,plg,str)

set(gcf,'color','white')
tm=linspace(-pi/2,pi/2,12)-pi/2;
pm=linspace(0,pi/2,24)+pi;


r=1;

[Tmm,Pmm]=meshgrid(tm,pm);


x1=r*sin(Tmm).*cos(Pmm);
y1=r*sin(Tmm).*sin(Pmm);
z1=r*cos(Tmm);

c=[0,0,0;1,1,1];



%rotation d'euler
az=az*pi/180;%45*pi/180;
plg=plg*pi/180;
str=str*pi/180;

%matrice de rotation azimutale
Aaz=[cos(az)  sin(az)   0
    -sin(az)  cos(az)   0
     0        0         1];
 %matrice de rotation en pendage
  plg=-pi/2+plg;
 Aplg=[cos(plg)   0    sin(plg)
       0          1    0    
      -sin(plg)   0    cos(plg)];
%matrice de rotation en strike
str=-str;
Astr=[1    0         0
      0   cos(str)  sin(str)
      0  -sin(str)  cos(str)];
 
 X1=zeros(size(x1)); Y1=zeros(size(y1)); Z1=zeros(size(z1));
 X2=zeros(size(x1)); Y2=zeros(size(y1)); Z2=zeros(size(z1));
 X3=zeros(size(x1)); Y3=zeros(size(y1)); Z3=zeros(size(z1));
 X4=zeros(size(x1)); Y4=zeros(size(y1)); Z4=zeros(size(z1));
 for i=1:size(x1,1)
     for j=1:size(x1,2)
       TMP1=Aaz*Aplg*Astr*[x1(i,j);y1(i,j);z1(i,j)];
       TMP2=Aaz*Aplg*Astr*[x1(i,j);-y1(i,j);z1(i,j)];
       TMP3=Aaz*Aplg*Astr*[-x1(i,j);-y1(i,j);z1(i,j)];
       TMP4=Aaz*Aplg*Astr*[-x1(i,j);y1(i,j);z1(i,j)];
        X1(i,j)=TMP1(1);X2(i,j)=TMP2(1);X3(i,j)=TMP3(1);X4(i,j)=TMP4(1);
        Y1(i,j)=TMP1(2);Y2(i,j)=TMP2(2);Y3(i,j)=TMP3(2);Y4(i,j)=TMP4(2);
        Z1(i,j)=TMP1(3);Z2(i,j)=TMP2(3);Z3(i,j)=TMP3(3);Z4(i,j)=TMP4(3);
     end
 end

 %axes de dilatation
 P=[2;-2;0];
 %axe de compression
 T=[2;2;0];
 %normale au plan de faille
 n=[2;0;0];
 %vecteur de glissement
 s=[0;2;0];
 %rotation des axes P T
 P=Aaz*Aplg*Astr*P;
 T=Aaz*Aplg*Astr*T;
 n=Aaz*Aplg*Astr*n;
 s=Aaz*Aplg*Astr*s;

% 
%figure()
try
    VIEW=get(gca,'view');
catch
    VIEW=[44,50];
end
hold off
colormap(c);
caxis([0,1])

% Z1(find(Z1>0))=NaN;
% Z2(find(Z2>0))=NaN;
% Z3(find(Z3>0))=NaN;
% Z4(find(Z4>0))=NaN;



surf(X1,Y1,Z1,zeros(size(z1)))
hold on
surf(X2,Y2,Z2,ones(size(z1)))
surf(X3,Y3,Z3,zeros(size(z1)))
surf(X4,Y4,Z4,ones(size(z1)))

% surf(X1,Y1,Z1,'FaceAlpha','flat','AlphaDataMapping','direct','AlphaData',0*ones(size(z1)),'facecolor','w')
% hold on
% surf(X2,Y2,Z2,'FaceAlpha','flat','AlphaDataMapping','direct','AlphaData',10*ones(size(z1)),'facecolor','w')
% surf(X3,Y3,Z3,'FaceAlpha','flat','AlphaDataMapping','direct','AlphaData',.5*ones(size(z1)),'facecolor','k')
% surf(X4,Y4,Z4,'FaceAlpha','flat','AlphaDataMapping','direct','AlphaData',.5*ones(size(z1)),'facecolor','k')


view(VIEW(1),VIEW(2));

line([-2,2],[0,0],[0,0],'color','g')
line([0,0],[-2,2],[0,0],'color','g')
line([0,0],[0,0],[-2,2],'color','g')
text(2,0,0,'East','color','b')
text(0,2,0,'North','color','b')
text(0,0,2,'Up','color','b')

line([-P(1),P(1)],[-P(2),P(2)],[-P(3),P(3)],'color','r')
line([-T(1),T(1)],[-T(2),T(2)],[-T(3),T(3)],'color','r')
text(P(1),P(2),P(3),'P')
text(T(1),T(2),T(3),'T')

nscolor=[1  .5  0];
line([0,s(1)],[0,s(2)],[0,s(3)],'color',nscolor)
line([0,n(1)],[0,n(2)],[0,n(3)],'color',nscolor)
text(1.80/norm(s)*s(1),1.80/norm(s)*s(2),1.80/norm(s)*s(3),'slip','color',nscolor)
text(1.80/norm(n)*n(1),1.80/norm(n)*n(2),1.80/norm(n)*n(3),'normal','color',nscolor)
%text(s(1),s(2),s(3),'slip','color',nscolor)
%text(n(1),n(2),n(3),'normal','color',nscolor)

%lighting phong
light
axis equal off
shading flat
%shading interp
