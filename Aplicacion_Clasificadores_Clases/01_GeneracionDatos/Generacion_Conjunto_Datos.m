addpath('..\funciones_histograma');
addpath('..\Funciones');
addpath('..\ImagenesPractica5\Entrenamiento');
addpath('..\ImagenesPractica5\Test');

clc,clear,close all

numClases=3;
numImagenesPorClase=2;
numDescriptores=23;


nombreDescriptores={'Compacticidad','Excentricidad','Solidez','Extent sin Rotacion','Extent con Rotacion','Hu1','Hu2','Hu3','Hu4','Hu5','Hu6','Hu7','DF1','DF2','DF3','DF4','DF5','DF6','DF7','DF8','DF9','DF10','Numero Euler'};

nombreClase{1}='Circulo';
nombreClase{2}='Cuadrado';
nombreClase{3}='Triangulo';

simbolosClases{1}='*r';
simbolosClases{2}='*b';
simbolosClases{3}='*g';

nombresProblema=[];
nombresProblema.descriptores=nombreDescriptores;
nombresProblema.clases=nombreClase;
nombresProblema.simbolos=simbolosClases;

XImagen=[];
YImagen=[];


for i=1:numClases
    for j=1:numImagenesPorClase
    nombreImagen=[nombreClase{i} num2str(j,'%02d') '.jpg'];
    I=imread(nombreImagen);
    umbral_otsu=funcion_Otsu(I);
    Ibin=I<umbral_otsu;
    IbinFilt=funcion_elimina_regiones_ruidosas(Ibin);
    
    [IEtiq N]=bwlabel(IbinFilt);

    XImagenaux=funcion_calcula_descriptores_imagen(IEtiq,N);
    XImagen=[XImagen;XImagenaux];
    
    for k=1:N
    YImagen=[YImagen;i];
    end

    end

end

save('..\DatosGenerados\Variables.mat','XImagen','YImagen');
save('..\DatosGenerados\nombresProblema.mat','nombresProblema','numDescriptores','numClases');







