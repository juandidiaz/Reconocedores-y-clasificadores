function Io=funcion_visualiza(Ii,Ib,Color,flagRepresenta)

[nf,nc,d]=size(Ii);

num=Ib==1;

if d==3
 Ir=Ii(:,:,1);
 Ir(num)=Color(1,1);
 Ig=Ii(:,:,2);
 Ig(num)=Color(1,2);
 Ib=Ii(:,:,3);
 Ib(num)=Color(1,3);

else
   Ir=Ii;
 Ir(num)=Color(1,1);
 Ig=Ii;
 Ig(num)=Color(1,2);
 Ib=Ii;
 Ib(num)=Color(1,3); 
end

Io=cat(3,Ir,Ig,Ib);



 if flagRepresenta==true
    figure,imshow(Io);
 end


end