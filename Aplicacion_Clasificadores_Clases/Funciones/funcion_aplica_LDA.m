function [YLDA,d]=funcion_aplica_LDA(X,vectorMedias,matrizCovarianza,probabilidadPriori,valoresClases)

YLDA=zeros(size(X,1),1);

[~,numValores]=size(valoresClases);

[~,dim]=size(X);

[~,descriptores]=size(X);

for i=1:descriptores
s='x';
num=num2str(i);
xtotal=[s num];
x(:,:,i)=sym(xtotal,'real');
end

Xs=[];
for i=1:descriptores

    valor=x(1,1,i);
    Xs=[Xs;valor];

end

for i=1:numValores
d(1,1,i)=expand(-0.5*(Xs-vectorMedias(:,i))'*pinv(matrizCovarianza)*(Xs-vectorMedias(:,i))+log(probabilidadPriori(i)));
end

d12=d(1,1,1)-d(1,1,2);

for i=1:size(X,1)

    if dim==2
    x1=X(i,1);
    x2=X(i,2);
    r=eval(d12);

    if r>0
    YLDA(i)=valoresClases(1);
    elseif r<0
     YLDA(i)=valoresClases(2);
    end

    elseif dim==3
    x1=X(i,1);
    x2=X(i,2);
    x3=X(i,3);
    r=eval(d12);

    if r>0
    YLDA(i)=valoresClases(1);
    elseif r<0
     YLDA(i)=valoresClases(2);
    end

    end
end


d=d12;


end