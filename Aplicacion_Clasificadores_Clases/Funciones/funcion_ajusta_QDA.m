function [vectorMedias, matricesCovarianzas,probabilidadPriori]=funcion_ajusta_QDA(X,Y)


[numClases,~]=size(unique(Y));
valoresCla=unique(Y);
[~,numDescriptores]=size(X);
vectorMedias=zeros(numDescriptores,numClases);

[~,numDescriptores]=size(X);

for i=1:numClases
    R=X(Y==valoresCla(i),:);
    vectorMedias(:,i)=mean(R)';
end

matricesCovarianzas=zeros(numDescriptores,numDescriptores,numClases);
probabilidadPriori=zeros(1,numClases);
numDatos=zeros(1,1,numClases);

for i=1:numClases
    filasX=X(Y==valoresCla(i));
    [numDatos(1,1,i) ~]=size(filasX);
    matricesCovarianzas(:,:,i)=cov(X(Y==valoresCla(i),:));
end

numDatosTotales=0;

for i=1:numClases
numDatosTotales=numDatos(1,1,i)+numDatosTotales;
end

for i=1:numClases
probabilidadPriori(1,i)=numDatos(1,1,i)/numDatosTotales;
end



end