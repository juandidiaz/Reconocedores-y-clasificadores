function [vectorMedias,MatrizCovarianza,probabilidadPriori]=funcion_ajusta_LDA(X,Y)

[numClases,~]=size(unique(Y));

valoresClases=unique(Y);

[~,numDescriptores]=size(X);
vectorMedias=zeros(numDescriptores,numClases);

for i=1:numClases

    R=X(Y==valoresClases(i),:);
    vectorMedias(:,i)=mean(R)';
    
end

MatrizCovarianza=zeros(numDescriptores,numDescriptores);

matrizCovClases=zeros(numDescriptores,numDescriptores,numClases);
probabilidadPriori=zeros(1,numClases);
numDatos=zeros(1,1,numClases);

for i=1:numClases
    filasX=X(Y==valoresClases(i));
    [numDatos(1,1,i) ~]=size(filasX);
    matrizCovClases(:,:,i)=cov(X(Y==valoresClases(i),:));
end

numDatosTotales=0;

for i=1:numClases
numDatosTotales=numDatos(1,1,i)+numDatosTotales;
end

for i=1:numClases
probabilidadPriori(1,i)=numDatos(1,1,i)/numDatosTotales;
end

for i=1:numClases
MatrizCovarianza=MatrizCovarianza+((numDatos(1,1,i)-1)*matrizCovClases(:,:,i));
end

MatrizCovarianza=MatrizCovarianza/numDatosTotales-numClases;

end