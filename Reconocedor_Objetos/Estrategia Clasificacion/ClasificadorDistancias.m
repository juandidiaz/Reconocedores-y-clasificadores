load('..\Variables\XY.mat');
addpath('..\funciones');
%Obtengo las filas de Objeto y de Color
FilasObjeto=Y==1;
FilasFondo=Y==0;


XColor=X(FilasObjeto,:);
XFondo=X(FilasFondo,:);
%Calculo los datos de las tres esferas teniendo XColor y XFondo
datosEsfera=calcula_datos_esfera(XColor,XFondo);

%Represento las tres esferas
for i=4:6


[R,G,B]=sphere(100);

x=datosEsfera(i)*R(:)+datosEsfera(1);
y=datosEsfera(i)*G(:)+datosEsfera(2);
z=datosEsfera(i)*B(:)+datosEsfera(3);


FilasObjeto=Y==1;
FilasFondo=Y==0;

figure,plot3(XColor(:,1),XColor(:,2),XColor(:,3),'.',XFondo(:,1),XFondo(:,2),XFondo(:,3),'.');
hold on,plot3(datosEsfera(1),datosEsfera(2),datosEsfera(3),'d');
hold on,plot3(x,y,z,'.g');


    if i==4
    title('Radio sin perdida de color');
    elseif i==5
    title('Radio sin ruido de fondo');
    elseif i==6
        title('Radio de compromiso');
    end
legend('Objeto','Fondo');

xlabel('Rojo');
ylabel('Verde');
zlabel('Azul');
xlim=[0 255];
ylim=[0 255];
zlim=[0 255];
end
%Divido la nube de puntos correspondientes al color en distintas
%agrupaciones, en este caso serán tres agrupaciones
numAgrup=3;

[idx centroides]=funcion_kmean(XColor,numAgrup);

[R G B]=sphere(100);
datosMultiplesEsferas=zeros(numAgrup,6);
%Obtengo los datos de las esferas para cada agrupacion y las represento
for i=1:numAgrup
FilasAgrup=idx==i; %Itero con las distintas agrupaciones
Agrupacion=XColor(FilasAgrup,:);
datos_esfera=calcula_datos_esfera(Agrupacion,XFondo);

%Guardo en una agrupacion sus centroides en las 3 primeras posiciones y sus
%3 radios en las 3 ultimas posiciones
datosMultiplesEsferas(i,1)=datos_esfera(1,1); 
datosMultiplesEsferas(i,2)=datos_esfera(1,2);
datosMultiplesEsferas(i,3)=datos_esfera(1,3);
datosMultiplesEsferas(i,4)=datos_esfera(1,4);
datosMultiplesEsferas(i,5)=datos_esfera(1,5);
datosMultiplesEsferas(i,6)=datos_esfera(1,6);

s1='Agrupacion ';
s2=num2str(i);
    for j=4:6
        figure,hold on,plot3(Agrupacion(:,1),Agrupacion(:,2),Agrupacion(:,3),'.',XFondo(:,1),XFondo(:,2),XFondo(:,3),'.y');
        x=datos_esfera(j)*R(:)+datos_esfera(1);
        y=datos_esfera(j)*G(:)+datos_esfera(2);
        z=datos_esfera(j)*B(:)+datos_esfera(3);
        hold on,plot3(x,y,z,'.g');
    
    
        if j==4
            title('Radio sin perdida de color');
        elseif j==5
            title('Radio sin ruido de fondo');
        elseif j==6
            title('Radio de compromiso');
        end
    
    s=[s1 s2];
    legend(s,'Fondo');
    
    end

xlabel('Rojo');
ylabel('Verde');
zlabel('Azul');
xlim=[0 255];
ylim=[0 255];
zlim=[0 255];
end

save('..\Variables\CentroideseIdx.mat','centroides','idx');
save('..\Variables\datosMultiplesEsferas.mat','datosMultiplesEsferas');

%Ver las imagenes con los distintos radios
load('..\Variables\Imagenes.mat');

[N,M,numComp,numImagenes]=size(I);
color=[0 255 0];

for i=1:numImagenes
Imagen=uint8(I(:,:,:,i));
s1='Imagen ';
s2=num2str(i);
s=[s1 s2];
figure,subplot(2,2,1),imshow(Imagen),title(s);

    for k=1:numAgrup
        for j=1:3
            centroides_radios=[datosMultiplesEsferas(k,1:3) datosMultiplesEsferas(k,j+3)];
            Ib=calcula_deteccion_esfera2(Imagen,centroides_radios);
            Io=funcion_visualiza(Imagen,Ib,color,false);

            subplot(2,2,j+1),imshow(Io); 
            if j+3==4
            title('Radio sin perdida de color');
            elseif j+3==5
            title('Radio sin ruido de fondo');
            elseif j+3==6
                title('Radio de compromiso')
            end
        end
    end

end

%Elijo el criterio de sin ruido de fondo datosMultiplesEsferas(5).

%Eliminar las posibles agrupaciones que no pertenezcan al objeto
%Calculo el numero de pixeles cuando el objeto esta lo mas alejado posible
Imagen=uint8(I(:,:,:,9));
[nf nc m]=size(Imagen);
ImagenesBinarias=logical(zeros(nf,nc,numAgrup));

for i=1:numAgrup
    centroides_radios=[datosMultiplesEsferas(i,1:3) datosMultiplesEsferas(i,5)];
    Ib=calcula_deteccion_esfera2(Imagen,centroides_radios);
        for j=1:nf
            for k=1:nc
            ImagenesBinarias(j,k,i)=Ib(j,k);
            end
        end
end

numPixeles=sum(ImagenesBinarias(:));

criteriosConectividad=round([0.25 0.5 0.75]*numPixeles);

%Muestro las imagenes con los distintos criterios de Conectividad
for i=1:numImagenes
Imagen=uint8(I(:,:,:,i));
s1='Imagen ';
s2=num2str(i);
s=[s1 s2];
figure,subplot(2,2,1),imshow(Imagen),title(s);
[nf nc m]=size(Imagen);
Ibaux=false(nf,nc,numAgrup);

    for k=1:numAgrup
    centroides_radios=[datosMultiplesEsferas(k,1:3) datosMultiplesEsferas(k,5)];
    Ib=calcula_deteccion_esfera2(Imagen,centroides_radios);
        for j=1:nf
            for l=1:nc
                Ibaux(j,l,k)=Ib(j,l);     
            end
        end
    end

IbArea=false(nf,nc);
    for k=1:numAgrup
    IbArea=or(IbArea,Ibaux(:,:,k));
    end
IbArea=logical(IbArea);

Im25=bwareaopen(IbArea,criteriosConectividad(1,1));
Im50=bwareaopen(IbArea,criteriosConectividad(1,2));
Im75=bwareaopen(IbArea,criteriosConectividad(1,3));

Im25=funcion_visualiza(Imagen,Im25,color,false);
Im50=funcion_visualiza(Imagen,Im50,color,false);
Im75=funcion_visualiza(Imagen,Im75,color,false);

subplot(2,2,2),imshow(Im25),title('0.25%');
subplot(2,2,3),imshow(Im50),title('0.50%');
subplot(2,2,4),imshow(Im75),title('0.75%');
end

%Elijo el primer criterio conectividad, el de 0.25%


save('..\Variables\ParametrosClasificador.mat','datosMultiplesEsferas','criteriosConectividad');










