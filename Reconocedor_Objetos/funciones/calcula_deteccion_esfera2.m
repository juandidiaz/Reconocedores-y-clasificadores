function Ib_dentroEsferas = calcula_deteccion_esfera2(Imagen,centroides_radio)
%Funcion de forma matricial
centroides=centroides_radio(1,1:3);
radio=centroides_radio(1,4);
I=double(Imagen);

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);



    dist = [sqrt((centroides(1)-R).^2+(centroides(2)-G).^2+(centroides(3)-B).^2)];
       
            Ib_dentroEsferas=dist<radio;
   
end