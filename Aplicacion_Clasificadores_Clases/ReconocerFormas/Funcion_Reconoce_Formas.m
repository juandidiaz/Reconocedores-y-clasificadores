function Funcion_Reconoce_Formas(Nombre)
addpath('..\Funciones');
addpath('..\funciones_histograma');
addpath('..\ImagenesPractica5\Test');
addpath('..\DatosGenerados');

%PARA KNN+LDA
addpath('..\Clasificadores\Circulos-TriangulosVSCuadrados\DatosClasificador');
addpath('..\Clasificadores\Circulo-Triangulo\DatosClasificador');

%PARA QDA
% addpath('..\Clasificadores\Circulo-Cuadrado-TriangulosQDA\DatosClasificador');

%PARA KNN
% addpath('..\Clasificadores\KNN\DatosClasificador');

%PARA LDA DOS A DOS
% addpath('..\Clasificadores\Circulo-Cuadrado\DatosClasificador');
% addpath('..\Clasificadores\Circulo-Triangulo\DatosClasificador');
% addpath('..\Clasificadores\Cuadrado-Triangulo\DatosClasificador');

%GENERAL
load('..\DatosGenerados\nombresProblema.mat');

nombreImagen=[Nombre '.jpg'];
I=imread(nombreImagen);

    umbral_otsu=funcion_Otsu(I);
    Ibin=I<umbral_otsu;
    [IEtiq N]=bwlabel(Ibin);

    XImagen=funcion_calcula_descriptores_imagen(IEtiq,N);

    medias=mean(XImagen);
    desv=std(XImagen);

    XImagen=(XImagen-medias);

[nf nc]=size(XImagen);

for i=1:nf
    for j=1:nc-1
        XImagen(i,j)=XImagen(i,j)/(desv(1,j)+eps);
    end
end


% % KNN + LDA
load('..\Clasificadores\Circulos-TriangulosVSCuadrados\DatosClasificador\Circulos-TriangVsCuadrados.mat');
load('..\Clasificadores\Circulos-TriangulosVSCuadrados\DatosClasificador\ConjuntoEntrenamiento.mat');


Z=XImagen(:,espacioCcas);

YTest=funcion_knn(Z,XEntrenamiento,YEntrenamiento,5);

load('..\Clasificadores\Circulo-Triangulo\DatosClasificador\Circ-Triang.mat');
load('..\Clasificadores\Circulo-Triangulo\DatosClasificador\FuncionCoeficientes.mat');

Z=XImagen(:,espacioCcas);

x1=sym('x1','real');
x2=sym('x2','real');
x3=sym('x3','real');

[nf nc]=size(Z);

for i=1:nf

    if YTest(i)==valoresClases(1)
    x1=Z(i,1);
    x2=Z(i,2);
    x3=Z(i,3);

    r=eval(d12);
    if r>0
        YTest(i)=valoresClases(1);
    elseif r<0
        YTest(i)=valoresClases(2);
    end
    end
end

for i=1:N
    Ibin=IEtiq==i;
    Clase=YTest(i);
    Io=funcion_visualiza(I,Ibin,[0 255 0],false);
    figure,subplot(1,2,1),imshow(Io);
    title(nombresProblema.clases{Clase});
    subplot(1,2,2),funcion_representa_hiperplano_separacion_2_3_Dim(coef_d12,XoI);
    hold on,funcion_representa_muestras_clasificacion_binaria(XoI,YoI,nombresProblema,espacioCcas);
    hold on, plot3(XImagen(i,1),XImagen(i,2),XImagen(i,3),'o');
end

%QDA
% load('..\Clasificadores\Circulo-Cuadrado-TriangulosQDA\DatosClasificador\Circulo-Cuadrado-Triangulo.mat');
% Z=XImagen(:,espacioCcas);
% 
% load('..\Clasificadores\Circulo-Cuadrado-TriangulosQDA\DatosClasificador\Funciones.mat');
% 
% [nf nc]=size(Z);
% 
% x1=sym('x1','real');
% x2=sym('x2','real');
% x3=sym('x3','real');
% x4=sym('x4','real');
% 
% for i=1:nf
% x1=Z(i,1);
% x2=Z(i,2);
% x3=Z(i,3);
% x4=Z(i,4);
% 
% r1=eval(d12);
% r2=eval(d13);
% r3=eval(d23);
% 
% if r1>0 & r2>0
%     YTest(i)=1;
% elseif r1<0 & r3>0
%     YTest(i)=2;
% elseif r2<0 & r3<0
%     YTest(i)=3;
% end
% 
% 
% end
% 
% for i=1:N
% Ibin=IEtiq==i;
% Io=funcion_visualiza(I,Ibin,[0 255 0],false);
% hold on,figure, imshow(Io),title(nombresProblema.clases{YTest(i)});
% end

%KNN
% 
% load('..\Clasificadores\KNN\DatosClasificador\Circulo-Cuadrado-TrianguloKNN.mat');
% load('..\Clasificadores\KNN\DatosClasificador\ConjuntoEntrenamiento.mat');
% 
% Z=XImagen(:,espacioCcas);
% YTest=funcion_knn(Z,XEntrenamiento,YEntrenamiento,5);
% 
% 
%     for i=1:N
%     Ibin=IEtiq==i;
%     Clase=YTest(i);
%     Io=funcion_visualiza(I,Ibin,[0 255 0],false);
%     figure,imshow(Io);
%     title(nombresProblema.clases{Clase});
%     end

%LDA dos a dos
% 
% load('..\Clasificadores\Circulo-Cuadrado\DatosClasificador\Circ-Cuadr.mat');
% load('..\Clasificadores\Circulo-Cuadrado\DatosClasificador\FuncionCoeficientes.mat');
% 
% Z=XImagen(:,espacioCcas);
% 
% x1=sym('x1','real');
% x2=sym('x2','real');
% x3=sym('x3','real');
% 
% [nf nc]=size(Z);
% 
% for i=1:nf
% 
%     x1=Z(i,1);
%     x2=Z(i,2);
%     x3=Z(i,3);
% 
%     r=eval(d12);
%     if r>0
%         YTest(i)=valoresClases(1);
%     elseif r<0
%         YTest(i)=valoresClases(2);
%     end
% end
% 
% 
% load('..\Clasificadores\Circulo-Triangulo\DatosClasificador\Circ-Triang.mat');
% load('..\Clasificadores\Circulo-Triangulo\DatosClasificador\FuncionCoeficientes.mat');
% 
% Z=XImagen(:,espacioCcas);
% 
% x1=sym('x1','real');
% x2=sym('x2','real');
% x3=sym('x3','real');
% 
% [nf nc]=size(Z);
% 
% for i=1:nf
% 
%     if YTest(i)==valoresClases(1)
%     x1=Z(i,1);
%     x2=Z(i,2);
%     x3=Z(i,3);
% 
%     r=eval(d12);
%     if r>0
%         YTest(i)=valoresClases(1);
%     elseif r<0
%         YTest(i)=valoresClases(2);
%     end
%     end
% end
% 
% load('..\Clasificadores\Cuadrado-Triangulo\DatosClasificador\Cuad-Triang.mat');
% load('..\Clasificadores\Cuadrado-Triangulo\DatosClasificador\FuncionCoeficientes.mat');
% 
% Z=XImagen(:,espacioCcas);
% 
% x1=sym('x1','real');
% x2=sym('x2','real');
% x3=sym('x3','real');
% 
% [nf nc]=size(Z);
% 
% for i=1:nf
%     if YTest(i)==valoresClases(1)
%     x1=Z(i,1);
%     x2=Z(i,2);
%     x3=Z(i,3);
% 
%     r=eval(d12);
%     if r>0
%         YTest(i)=valoresClases(1);
%     elseif r<0
%         YTest(i)=valoresClases(2);
%     end
%     end
% end
% 
% 
%     for i=1:N
%     Ibin=IEtiq==i;
%     Clase=YTest(i);
%     Io=funcion_visualiza(I,Ibin,[0 255 0],false);
%     figure,subplot(2,2,1),imshow(Io);
%     title(nombresProblema.clases{Clase});
%     load('..\Clasificadores\Circulo-Cuadrado\DatosClasificador\Circ-Cuadr.mat');
%     load('..\Clasificadores\Circulo-Cuadrado\DatosClasificador\FuncionCoeficientes.mat');
% 
%     hold on,subplot(2,2,2),funcion_representa_hiperplano_separacion_2_3_Dim(coef_d12,Z);
%     hold on, funcion_representa_muestras_clasificacion_binaria(XoI,YoI,nombresProblema,espacioCcas,valoresClases);
%     hold on, plot3(XImagen(i,1),XImagen(i,2),XImagen(i,3),'o');
% 
%     load('..\Clasificadores\Circulo-Triangulo\DatosClasificador\Circ-Triang.mat');
%     load('..\Clasificadores\Circulo-Triangulo\DatosClasificador\FuncionCoeficientes.mat');
% 
%     hold on,subplot(2,2,3),funcion_representa_hiperplano_separacion_2_3_Dim(coef_d12,Z);
%     hold on, funcion_representa_muestras_clasificacion_binaria(XoI,YoI,nombresProblema,espacioCcas,valoresClases);
%     hold on, plot3(XImagen(i,1),XImagen(i,2),XImagen(i,3),'o');
% 
%     load('..\Clasificadores\Cuadrado-Triangulo\DatosClasificador\Cuad-Triang.mat');
%     load('..\Clasificadores\Cuadrado-Triangulo\DatosClasificador\FuncionCoeficientes.mat');
% 
%     hold on,subplot(2,2,4),funcion_representa_hiperplano_separacion_2_3_Dim(coef_d12,Z);
%     hold on, funcion_representa_muestras_clasificacion_binaria(XoI,YoI,nombresProblema,espacioCcas,valoresClases);
%     hold on, plot3(XImagen(i,1),XImagen(i,2),XImagen(i,3),'o');
%     end

end

    
