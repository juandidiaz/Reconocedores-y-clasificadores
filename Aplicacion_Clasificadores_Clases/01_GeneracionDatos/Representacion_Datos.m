clc,clear,close all
addpath('..\DatosGenerados');
addpath('..\Funciones');
load('..\DatosGenerados\nombresProblema.mat')
load('..\DatosGenerados\Variables.mat');



for i=1:2:numDescriptores-1-1
    espacioCcas=[i i+1];
funcion_representa_datos(XImagen,YImagen,espacioCcas,nombresProblema);
end

[numMuestras nc]=size(XImagen);
for j=1:numDescriptores-1

% Valores máximo y mínimos para representar en la misma escala
vMin = min(XImagen(:,j));
vMax = max(XImagen(:,j));

hFigure = figure; hold on
bpFigure = figure; hold on

for i=1:numClases

Xij = XImagen(YImagen==i,j); % datos clase i del descriptor j


figure(hFigure)
subplot(numClases,1,i), hist(Xij),
xlabel(nombresProblema.descriptores{j})
ylabel('Histograma')
axis([ vMin,vMax,0,numMuestras/4]) % inf escala automática eje y
title(nombresProblema.clases{i})

figure(bpFigure)
subplot(1,numClases,i), boxplot(Xij)
xlabel('Diagrama de Caja')
ylabel(nombresProblema.descriptores{j})
axis([ 0,2,vMin,vMax ])
title(nombresProblema.clases{i})
end
end