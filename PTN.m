function [P,T,N,Pfoc,Tfoc,Nfoc]=PTN(az,dip,rak)


if nargin == 0
disp('permet de calculer les coordonnees cartesiennes (base East,North,Up)')
disp('des axes P t et N, ainsi que leurs azimuts et pendages respectifs en degres')
disp('a partir des strike dip rake du mecanisme (tout en degre)')
disp('--------------------------------------------------------------------')
disp('entrer :')
disp('    az   = azimut du plan nodal (degres)')
disp('    dip  = pendage du plan nodal (degres)')
disp('    rak  = angle de glissment (degres)')
if nargout ==0
disp('en sortie :')
disp('    P    = [Px;Py;Pz] = composantes du vecteur P (cadran blanc dillatation) dans la base (East, North,Up), le vecteur est norme')
disp('    T    = [Tx;Ty;Tz] = composantes du vecteur T (cadran noir compression)  dans la base (East, North,Up), le vecteur est norme')
disp('    N    = [Nx;Ny;Nz] = composantes du vecteur N                            dans la base (East, North,Up), le vecteur est norme')
disp('    Pfoc = [Paz;Pdip] = azimut et pendage de l''axe P tout en degres')
disp('    Tfoc = [Taz;Tdip] = azimut et pendage de l''axe T tout en degres')
disp('    Nfoc = [Naz;Tdip] = azimut et pendage de l''axe N tout en degres')
end
return
end
if nargout ==0
disp('en sortie :')
disp('    P    = [Px;Py;Pz] = composantes du vecteur P (cadran blanc dillatation) dans la base (East, North,Up), le vecteur est norme')
disp('    T    = [Tx;Ty;Tz] = composantes du vecteur T (cadran noir compression)  dans la base (East, North,Up), le vecteur est norme')
disp('    N    = [Nx;Ny;Nz] = composantes du vecteur N                            dans la base (East, North,Up), le vecteur est norme')
disp('    Pfoc = [Paz;Pdip] = azimut et pendage de l''axe P tout en degres')
disp('    Tfoc = [Taz;Tdip] = azimut et pendage de l''axe T tout en degres')
disp('    Nfoc = [Naz;Tdip] = azimut et pendage de l''axe N tout en degres')
end

    %rotation d'euler
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

    P=Aaz*Adip*Arak*[sqrt(.5);-sqrt(.5);0];
    T=Aaz*Adip*Arak*[sqrt(.5);sqrt(.5);0];
    N=Aaz*Adip*Arak*[0;0;1];

    P=P./norm(P);
    T=T./norm(T);
    N=N./norm(N);

    Pdip=asin(-P(3));
    Paz=asin(P(1)/cos(Pdip));
    if P(2)/cos(Pdip)<0
        Paz=pi-Paz;
    end
    Pfoc=[Paz*180/pi;Pdip*180/pi];
    Tdip=asin(-T(3));
    Taz=asin(T(1)/cos(Tdip));
    if T(2)/cos(Tdip)<0
        Taz=pi-Taz;
    end
    Tfoc=[Taz*180/pi;Tdip*180/pi];
    Ndip=asin(-N(3));
    Naz=asin(N(1)/cos(Ndip));
    if N(2)/cos(Ndip)<0
        Naz=pi-Naz;
    end
    Nfoc=[Naz*180/pi;Ndip*180/pi];    
end
