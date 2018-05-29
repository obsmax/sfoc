function [S,Saz,Sdip]=slip(az,dip,rak)

if nargin == 0
disp('permet de calculer les composante du vecteur de glissement dans la base cartesienne (x=Est,y=Nord,z=Up)')
disp('a partir des strike dip rake (tout en degres) decrivants le mecanisme au foyer')
disp('le programme rend egalement l''azimut en degre du vecteur de glissement et son pendage en degres')
disp('-------------------------------------------------------------------------------------------------------')
disp('entrer :')
disp('    az  = azimut du plan nodal en degres')
disp('    dip = pendage du plan nodal en degres')
disp('    rak = angle de glissement en degres')
if nargout == 0
disp('en sortie :')
disp('    S    = composante du vecteur de glissement dans la base cartesienne (East North Up) (le vecteur est norme)')
disp('    Saz  = azimut du vecteur de glissement')
disp('    Sdip = pendage du vecteur de glissement')
end
return
end

if nargout == 0
disp('en sortie :')
disp('    S    = composantes [Sx;Sy;Sz] du vecteur de glissement dans la base cartesienne (East North Up) (le vecteur est norme)')
disp('    Saz  = azimut du vecteur de glissement')
disp('    Sdip = pendage du vecteur de glissement')
end



    %rotation d'euler

    %passage en rad
    az=az*pi/180;
    dip=dip*pi/180;
    rak=rak*pi/180;

    %matrice de rotation azimutale
    Aaz=[cos(az)  sin(az)   0
        -sin(az)  cos(az)   0
         0        0         1];
     %matrice de rotation en pendage
     dip=-pi/2+dip;
     Adip=[cos(dip)   0    sin(dip)
           0          1    0    
          -sin(dip)   0    cos(dip)];
    %matrice de rotation en strike
    rak=-rak;
    Arak=[1    0          0
          0    cos(rak)   sin(rak)
          0    -sin(rak)  cos(rak)];
    
    S=Aaz*Adip*Arak*[0;1;0];

    S=S./norm(S);

    Sdip=asin(-S(3));
    Saz=asin(S(1)/cos(Sdip));

    
    if S(2)/cos(Sdip)<0
        %Sdip=-Sdip;
        Saz=pi-Saz;
    end
    
    %retour en degres
    Saz=Saz*180/pi;
    Sdip=Sdip*180/pi;
end
