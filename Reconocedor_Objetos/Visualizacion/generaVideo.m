addpath('..\funciones');
load('..\Variables\ParametrosClasificador.mat');

aviobjI=VideoReader('..\Generacion de Material\VideoNaranja.avi');
get(aviobjI);

NumeroFrames=aviobjI.Duration*aviobjI.FrameRate;
NumFilasFrame=aviobjI.Height;
NumColumnasFrame=aviobjI.Width;
FPS=aviobjI.FrameRate;

aviobjO=VideoWriter('VideoNaranja.avi','Uncompressed AVI');
aviobjO.FrameRate=FPS;

open(aviobjO);

aviobjI.CurrentTime=0;

[numAgrup aux]=size(datosMultiplesEsferas);

for i=1:NumeroFrames
    %Leo el frame
    I=readFrame(aviobjI);
    %Creo una matriz logica de ceros del tamaño del frame
    Ibarea=false(NumFilasFrame,NumColumnasFrame);
    %Para cada agrupacion calculo los pixeles que se encuentran dentro de
    %las esferas y si se encuentran dentro son pixeles del objeto
    for j=numAgrup
    centroides_radio=[datosMultiplesEsferas(j,1:3) datosMultiplesEsferas(j,5)];
    Ib=calcula_deteccion_esfera2(I,centroides_radio);
    Ibarea=or(Ibarea,Ib);
    end
    %Creo la matriz etiquetada utilizando la matriz logica anterior y
    %obtengo el centroide de las agrupaciones de la imagen
    IEtiq=bwareaopen(Ibarea,criteriosConectividad(1));
    stats=regionprops(IEtiq,'Centroid');
    centroide=cat(1,stats.Centroid);
    [nf nc]=size(centroide);
    IVideo=I;
    %Si existe un centroide
    if nf>0
        %Obtengo las coordenadas x e y
        x=round(centroide(:,1));
        y=round(centroide(:,2));
        %Si el centroide no se encuentra en uno de los bordes
        if(y>2 & y<NumFilasFrame-1) & (x>2 & x<NumColumnasFrame-1)
            %Cambio la componente roja a 255 y las otras dos componenentes
            %a 0.
        IVideo(y-2:y+2,x-2:x+2,1)=255;
        IVideo(y-2:y+2,x-2:x+2,2)=0;
        IVideo(y-2:y+2,x-2:x+2,3)=0;
            end
    end
    writeVideo(aviobjO,IVideo);


end

close(aviobjO);