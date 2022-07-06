addpath('..\..\DatosGenerados');
load('..\..\DatosGenerados\DatosEstandarizados.mat');

XEntrenamiento=Z(:,:);YEntrenamiento=YImagen;

[espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XEntrenamiento,YEntrenamiento,5);
XEntrenamiento=XEntrenamiento(:,espacioCcas);
save('.\DatosClasificador\Circulo-Cuadrado-TrianguloKNN.mat','espacioCcas','JespacioCcas','XEntrenamiento','YEntrenamiento');