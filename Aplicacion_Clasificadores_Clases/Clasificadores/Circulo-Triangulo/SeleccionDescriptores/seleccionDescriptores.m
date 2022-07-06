addpath('..\..\DatosGenerados');
load('..\..\DatosGenerados\DatosEstandarizados.mat');

XoI=Z(:,:);YoI=YImagen;

XoI(YImagen==2,:)=[];
YoI(YImagen==2,:)=[];
valoresClases=[1,3];

[espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XoI,YoI,3);

XoI=XoI(:,espacioCcas);
save('.\DatosClasificador\Circ-Triang.mat','espacioCcas','JespacioCcas','XoI','YoI','valoresClases');

