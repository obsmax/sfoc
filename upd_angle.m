function b=upd_angle(a)
%tout en degre
%sert a ramener un angle entre 0 et 360 degre
    while a<0
        a=a+360;
    end
    while a > 360
        a=a-360;
    end
    b=a;
end
