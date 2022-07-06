addpath('..\..\DatosGenerados');
load('..\..\DatosGenerados\DatosEstandarizados.mat');

XoI=Z(:,:);YoI=YImagen;

XoI(YImagen==3,:)=[];
YoI(YImagen==3,:)=[];
valoresClases=[1,2];
[espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XoI,YoI,3);
XoI=XoI(:,espacioCcas);
save('.\DatosClasificador\Circ-Cuadr.mat','espacioCcas','JespacioCcas','XoI','YoI','valoresClases');

