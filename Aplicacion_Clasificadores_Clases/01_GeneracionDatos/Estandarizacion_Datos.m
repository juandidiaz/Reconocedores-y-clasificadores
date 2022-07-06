clc,clear,close all
addpath('..\DatosGenerados');
addpath('..\Funciones');
load('..\DatosGenerados\nombresProblema.mat')
load('..\DatosGenerados\Variables.mat');


medias=mean(XImagen);
desv=std(XImagen);

save('..\DatosGenerados\medias_desviaciones_estandarizacion.mat','medias','desv');

Z=XImagen;

[nf nc]=size(Z);


for i=1:nf
    for j=1:nc-1
        Z(i,j)=Z(i,j)-medias(1,j);
    end
end

for i=1:nf
    for j=1:nc-1
        Z(i,j)=Z(i,j)/(desv(1,j)+eps);
    end
end


%%EJERCICIO
save('..\DatosGenerados\DatosEstandarizados.mat','Z','YImagen');
%CIRCULOS VS CUADRADOS VS TRIANGULOS
XoI=Z(:,:);YoI=YImagen;


[espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XoI,YoI,3);
funcion_representa_datos(XoI,YoI,espacioCcas,nombresProblema);
s1='Grado de separabilidad: ';
s2=num2str(JespacioCcas);
S=[s1 s2];
title(S);
save('..\DatosGenerados\CirculosCuadradosTriangulos.mat','espacioCcas','JespacioCcas');

%CIRCULOS VS CUADRADOS
XoI=Z(:,:);YoI=YImagen;

XoI(YImagen==3,:)=[];
YoI(YImagen==3,:)=[];

[espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XoI,YoI,3);
funcion_representa_datos(XoI,YoI,espacioCcas,nombresProblema);
s1='Grado de separabilidad: ';
s2=num2str(JespacioCcas);
S=[s1 s2];
title(S);
save('..\DatosGenerados\CirculosCuadrados.mat','espacioCcas','JespacioCcas');

%CIRCULOS VS TRIANGULOS
XoI=Z(:,:);YoI=YImagen;

XoI(YImagen==2,:)=[];
YoI(YImagen==2,:)=[];

[espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XoI,YoI,3);
funcion_representa_datos(XoI,YoI,espacioCcas,nombresProblema);
s1='Grado de separabilidad: ';
s2=num2str(JespacioCcas);
S=[s1 s2];
title(S);
save('..\DatosGenerados\CirculosTriangulos.mat','espacioCcas','JespacioCcas');

%CUADRADOS VS TRIANGULOS
XoI=Z(:,:);YoI=YImagen;

XoI(YImagen==1,:)=[];
YoI(YImagen==1,:)=[];

[espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XoI,YoI,3);
funcion_representa_datos(XoI,YoI,espacioCcas,nombresProblema);
s1='Grado de separabilidad: ';
s2=num2str(JespacioCcas);
S=[s1 s2];
title(S);
save('..\DatosGenerados\CuadradosTriangulos.mat','espacioCcas','JespacioCcas');

%CIRCULOS-TRIANGULOS VS CUADRADOS
XoI=Z(:,:);YoI=YImagen;

YoI(YImagen==3,:)=1;

[espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XoI,YoI,3);
funcion_representa_datos(XoI,YoI,espacioCcas,nombresProblema);
s1='Grado de separabilidad: ';
s2=num2str(JespacioCcas);
S=[s1 s2];
title(S);
legend('Circulos-Triangulos','Cuadrados');
save('..\DatosGenerados\Circulos-TriangulosCuadrados.mat','espacioCcas','JespacioCcas');




