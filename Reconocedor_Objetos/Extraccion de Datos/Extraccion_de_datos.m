load('..\Variables\fotos_calibracion.mat'); %Cargar las fotos

I=[];
%Fondo
I(:,:,:,1)=imresize(fondo,[240 NaN]);
%Sin objeto
I(:,:,:,2)=imresize(sin_objeto,[240 NaN]);
I(:,:,:,3)=imresize(sin_objeto_centro,[240 NaN]);
I(:,:,:,4)=imresize(sin_objeto_derecha,[240 NaN]);
I(:,:,:,5)=imresize(sin_objeto_izquierda,[240 NaN]);
I(:,:,:,6)=imresize(sin_objeto_izquierda2,[240 NaN]);
I(:,:,:,7)=imresize(mano_alejada,[240 NaN]);
%Con objeto
I(:,:,:,8)=imresize(objeto_alejado,[240 NaN]);
I(:,:,:,9)=imresize(objeto_alejado2,[240 NaN]);
I(:,:,:,10)=imresize(objeto_alejado3,[240 NaN]);
I(:,:,:,11)=imresize(objeto_cerca,[240 NaN]);
I(:,:,:,12)=imresize(objeto_cerca_izquierda,[240 NaN]);
I(:,:,:,13)=imresize(objeto_cerca_derecha,[240 NaN]);
I(:,:,:,14)=imresize(objeto_izquierda,[240 NaN]);
I(:,:,:,15)=imresize(objeto_izquierda2,[240 NaN]);

save('..\Variables\Imagenes.mat','I');

%Hacer los roipoly de las imagenes de las cuales obtengo el color
DatosColor=[];
for i=8:15
  Imagen=uint8(I(:,:,:,i));
  ROE=roipoly(Imagen);
  R=Imagen(:,:,1); G=Imagen(:,:,2); B=Imagen(:,:,3);

  DatosColor=[DatosColor; i*ones(size(R(ROE==1))),double(R(ROE==1)), double(G(ROE==1)),double(B(ROE==1))];
end

%Hacer los roipoly de las imagenes para obtener el fondo
DatosFondo=[]
for i=1:7
Imagen=uint8(I(:,:,:,i));
ROE=roipoly(Imagen);
R=Imagen(:,:,1);G=Imagen(:,:,2);B=Imagen(:,:,3);

  DatosFondo=[DatosFondo; ones(size(R(ROE==1))),double(R(ROE==1)),double(G(ROE==1)),double(B(ROE==1))];
end
 
save('..\Variables\DatosColoryFondo.mat','DatosColor','DatosFondo');

[nf nc]=size(DatosColor);
%Creo X concatenando DatosColor y DatosFondo(sin añadir la primera columna
X=[DatosColor(:,2:4);DatosFondo(:,2:4)];
%Creo Y indicando cuales son colores pertenecientes al objeto
Y=[];
for i=1:nf
   Y(i,:)=1; 
end



[nfY ncY]=size(Y);

[nfF nc]=size(DatosFondo);
%A partir del final de Y, empiezo a rellenar con 0 para decir que es un
%color de fondo
for i=nfY:nf+nfF
Y(i,:)=0;
end

save('..\Variables\XY.mat','X','Y');
%Obtengo las filas de Objeto y las de Fondo
FilasObjeto=Y==1;
FilasFondo=Y==0;
%Representar las distintas nubes de puntos
plot3(X(FilasObjeto,1),X(FilasObjeto,2),X(FilasObjeto,3),'.',X(FilasFondo,1),X(FilasFondo,2),X(FilasFondo,3),'.');
legend('Objeto','Fondo');

xlabel('Rojo');
ylabel('Verde');
zlabel('Azul');
xlim=[0 255];
ylim=[0 255];
zlim=[0 255];

%Quitar los outliers
%Obtengo las filas de Objeto
FilasObjeto=Y==1;
%Obtengo las distintas componentes de los colores del objeto
R=double(X(FilasObjeto,1));
G=double(X(FilasObjeto,2));
B=double(X(FilasObjeto,3));
%Hallo el minimo y maximo de los outliers con la media y desviacion tipica
Rmin=mean(R)-(3*std(R)); Rmax=mean(R)+(3*std(R));
Gmin=mean(G)-(3*std(G));Gmax=mean(G)+(3*std(G));
Bmin=mean(B)-(3*std(B));Bmax=mean(B)+(3*std(B));

Rmin=int8(Rmin);Rmax=int8(Rmax);
Gmin=int8(Gmin);Gmax=int8(Gmax);
Bmin=int8(Bmin);Bmax=int8(Bmax);

%Obtengo las filas donde los colores de los objetos pasan los minimos o
%maximos y los elimino
OutliersRojosmax=X(FilasObjeto,1)>Rmax; 
OutliersRojosmin=X(FilasObjeto,1)<Rmin;
X(OutliersRojosmax,:)=[];
Y(OutliersRojosmax)=[];
X(OutliersRojosmin,:)=[];
Y(OutliersRojosmin)=[];

FilasObjeto=Y==1;

OutliersVerdesmax=X(FilasObjeto,2)>Gmax;
OutliersVerdesmin=X(FilasObjeto,2)<Gmin;
X(OutliersVerdesmax,:)=[];
Y(OutliersVerdesmax)=[];
X(OutliersVerdesmin,:)=[];
Y(OutliersVerdesmin)=[];

FilasObjeto=Y==1;
OutliersAzulesmax=X(FilasObjeto,3)>Bmax;
OutliersAzulesmin=X(FilasObjeto,3)<Bmin;
X(OutliersAzulesmax,:)=[];
Y(OutliersAzulesmax)=[];
X(OutliersAzulesmin,:)=[];
Y(OutliersAzulesmin)=[];


FilasObjeto=Y==1;
FilasFondo=Y==0;

figure,plot3(X(FilasObjeto,1),X(FilasObjeto,2),X(FilasObjeto,3),'.',X(FilasFondo,1),X(FilasFondo,2),X(FilasFondo,3),'.');
legend('Objeto','Fondo');

xlabel('Rojo');
ylabel('Verde');
zlabel('Azul');
xlim=[0 255];
ylim=[0 255];
zlim=[0 255];

save('..\Variables\XY.mat','X','Y');



