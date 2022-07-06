function [idx, centroides]=funcion_kmean(XColor,numAgrup)

[nf nc]=size(XColor);
idx=zeros(nf,1);


aleatorios=randsample(nf,numAgrup);

centroides=zeros(numAgrup,3);

    for i=1:numAgrup
    centroides(i,1)=XColor(aleatorios(i),1);
    centroides(i,2)=XColor(aleatorios(i),2);
    centroides(i,3)=XColor(aleatorios(i),3);
    end

    for i=1:nf

        dist=sqrt(sum(centroides(1,1)-XColor(i,1)).^2+sum(centroides(1,2)-XColor(i,2)).^2+sum(centroides(1,3)-XColor(i,3)).^2);
        idx(i)=1;
    
        for j=2:numAgrup
        distancia=sqrt(sum(centroides(j,1)-XColor(i,1)).^2+sum(centroides(j,2)-XColor(i,2)).^2+sum(centroides(j,3)-XColor(i,3)).^2);
            if distancia<dist
                idx(i)=j;
            end
        end
    end
    
    idx_aux=zeros(nf,1);

    while ~funcion_compara_matrices(idx_aux,idx)
        idx_aux=idx;
        for i=1:numAgrup
            FilasAgrup=idx==i;
            centroides(i,1)=mean(XColor(FilasAgrup,1));
            centroides(i,2)=mean(XColor(FilasAgrup,2));
            centroides(i,3)=mean(XColor(FilasAgrup,3));
        end

        for i=1:nf
            dist=sqrt(sum(centroides(1,1)-XColor(i,1)).^2+sum(centroides(1,2)-XColor(i,2)).^2+sum(centroides(1,3)-XColor(i,3)).^2);
            idx(i)=1;
    
            for j=2:numAgrup
                distancia=sqrt(sum(centroides(j,1)-XColor(i,1)).^2+sum(centroides(j,2)-XColor(i,2)).^2+sum(centroides(j,3)-XColor(i,3)).^2);
                if distancia<dist
                    idx(i)=j;
                end
            end
        end
    end
end
