addpath('..\..\DatosGenerados');
load('..\..\DatosGenerados\DatosEstandarizados.mat');

XEntrenamiento=Z(:,:);YEntrenamiento=YImagen;

YEntrenamiento(YImagen==3,:)=1;

[espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XEntrenamiento,YEntrenamiento,4);
XEntrenamiento=XEntrenamiento(:,espacioCcas);
save('.\DatosClasificador\Circulos-TriangVsCuadrados.mat','espacioCcas','JespacioCcas','XEntrenamiento','YEntrenamiento');
