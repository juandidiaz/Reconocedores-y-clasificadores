addpath('..\..\DatosGenerados');
load('..\..\DatosGenerados\DatosEstandarizados.mat');

XoI=Z(:,:);YoI=YImagen;

XoI(YImagen==1,:)=[];
YoI(YImagen==1,:)=[];
valoresClases=[2,3];
[espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XoI,YoI,3);
XoI=XoI(:,espacioCcas);
save('.\DatosClasificador\Cuad-Triang.mat','espacioCcas','JespacioCcas','XoI','YoI','valoresClases');
