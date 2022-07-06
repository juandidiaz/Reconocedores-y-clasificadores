function datosEsfera=calcula_datos_esfera(XColor,XFondo)

datosEsfera=zeros(1,6);

centroide=mean(XColor);
dist_uno=0;

    for i=1:size(XColor,1)

    distancia=sqrt(sum(centroide(1)-XColor(i,1)).^2+sum(centroide(2)-XColor(i,2)).^2+sum(centroide(3)-XColor(i,3)).^2);
        if dist_uno<distancia
        dist_uno=distancia;
        end

    end

dist_dos=sqrt(sum(centroide(1)-XFondo(1,1)).^2+sum(centroide(2)-XFondo(1,2)).^2+sum(centroide(3)-XFondo(1,3)).^2);

    for i=2:size(XFondo,1)
    distancia=sqrt(sum(centroide(1)-XFondo(i,1)).^2+sum(centroide(2)-XFondo(i,2)).^2+sum(centroide(3)-XFondo(i,3)).^2);

        if distancia<dist_dos
        dist_dos=distancia;
        end
    end

dist_tres=(dist_uno+dist_dos)/2;

datosEsfera=[centroide(1),centroide(2),centroide(3),dist_uno,dist_dos,dist_tres];

end