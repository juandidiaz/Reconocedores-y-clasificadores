function [espacioCcas,JespacioCcas]=funcion_selecciona_vector_ccas(XoI,YoI,dim)


combinaciones=combnk(1:22,dim);

[nf nc]=size(combinaciones);

Jaux=zeros(nf,1);

    for i=1:nf
        espacio=combinaciones(i,:);  
        X=XoI(:,espacio);
        Jaux(i,1)=indiceJ(X,YoI);
    end

   espacioCcas=combinaciones(Jaux>=0.1,:);

   [JespacioCcas indMaximo]=max(Jaux);

    espacioCcas=combinaciones(indMaximo,:);
end