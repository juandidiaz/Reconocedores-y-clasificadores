function [YQDA d]=funcion_aplica_QDA(X,vectorMedias,matricesCovarianzas,probabilidadPriori,valoresClases)

[~,numValores]=size(valoresClases);

YQDA=zeros(size(X,1),1);

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
d(1,1,i)=expand(-0.5*(Xs-vectorMedias(:,i))'*pinv(matricesCovarianzas(:,:,i))*(Xs-vectorMedias(:,i))-0.5*log(det(matricesCovarianzas(:,:,i)))+log(probabilidadPriori(i)));
end

if numValores==2
  d12=d(1,1,1)-d(1,1,2);
for i=1:size(X,1)

    for j=1:descriptores
        Xs(j,1)=X(i,j);
    end
    x1=Xs(1,1);
    x2=Xs(2,1);
    x3=Xs(3,1);
    x4=Xs(4,1);
    

    r=eval(d12);

    if r>0
    YQDA(i)=valoresClases(1);
    elseif r<0
        YQDA(i)=valoresClases(2);
    end
    

end

elseif numValores==3

d12=d(1,1,1)-d(1,1,2);
d13=d(1,1,1)-d(1,1,3);
d23=d(1,1,1)-d(1,1,3);

for i=1:size(X,1)

    for j=1:descriptores
    Xs(j,1)=X(i,j);
    end
    x1=Xs(1,1);
    x2=Xs(2,1);
    x3=Xs(3,1);
    x4=Xs(4,1);

    r1=eval(d12);
    r2=eval(d13);
    r3=eval(d23);

    if r1>0 & r2>0
    YQDA(i)=valoresClases(1,1);
    elseif r1<0 & r3>0
        YQDA(i)=valoresClases(1,2);
    elseif r2<0 & r3<0
        YQDA(i)=valoresClases(1,3);
    end


end
end






end