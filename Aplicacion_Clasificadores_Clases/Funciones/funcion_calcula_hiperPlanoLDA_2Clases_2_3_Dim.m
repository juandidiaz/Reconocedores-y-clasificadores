function [d1,d2,d12 coef_d12]=funcion_calcula_hiperPlanoLDA_2Clases_2_3_Dim(X,Y)

[~,dim]=size(X);

[vectorMedias,matrizCovarianza,probabilidadPriori]=funcion_ajusta_LDA(X,Y);

if dim==2

x1=sym('x1','real');
x2=sym('x2','real');

Xs=[x1;x2];

d1=expand(-0.5*(Xs-vectorMedias(1))'*pinv(matrizCovarianza)*(Xs-vectorMedias(1))+log(probabilidadPriori(1)));

d2=expand(-0.5*(Xs-vectorMedias(2))'*pinv(matrizCovarianza)*(Xs-vectorMedias(2))+log(probabilidadPriori(2)));

d12=d1-d2;

%Coeficientes
x1=0;x2=0;C=eval(d12);
x1=1;x2=0;A=eval(d12)-C;
x1=0;x2=1;B=eval(d12)-C;

coef_d12=[A,B,C];

elseif dim==3
x1=sym('x1','real');
x2=sym('x2','real');
x3=sym('x3','real');

Xs=[x1;x2;x3];

d1=expand(-0.5*(Xs-vectorMedias(:,1))'*pinv(matrizCovarianza)*(Xs-vectorMedias(:,1))+log(probabilidadPriori(1)));

d2=expand(-0.5*(Xs-vectorMedias(:,2))'*pinv(matrizCovarianza)*(Xs-vectorMedias(:,2))+log(probabilidadPriori(2)));

d12=d1-d2;

x1=0;x2=0;x3=0;D=eval(d12);
x1=1;x2=0;x3=0;A=eval(d12)-D;
x1=0;x2=1;x3=0;B=eval(d12)-D;
x1=0;x2=0;x3=1;C=eval(d12)-D;

coef_d12=[A,B,C,D];
end


end
