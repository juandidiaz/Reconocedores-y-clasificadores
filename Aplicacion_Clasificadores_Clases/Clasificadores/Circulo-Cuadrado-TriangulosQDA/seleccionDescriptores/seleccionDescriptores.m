addpath('..\..\DatosGenerados');
load('..\..\DatosGenerados\DatosEstandarizados.mat');

XoI=Z;YoI=YImagen;

[espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XoI,YoI,4);
XoI=XoI(:,espacioCcas);
save('.\DatosClasificador\Circulo-Cuadrado-Triangulo.mat','espacioCcas','JespacioCcas','XoI','YoI');
