function funcion_representa_hiperplano_separacion_2_3_Dim(coef_d12,X)

[~,dim]=size(X);

x1Min=min(X(:,1));x1Max=max(X(:,1));
x2Min=min(X(:,2));x2Max=max(X(:,2));

paso=0.05;

if dim==3
A=coef_d12(1);
B=coef_d12(2);
C=coef_d12(3);
D=coef_d12(4);

[x1Plano, x2Plano]=meshgrid(x1Min:paso:x1Max,x2Min:paso:x2Max);
x3Plano=-(A*x1Plano+B*x2Plano+D)/(C+eps);
surf(x1Plano,x2Plano,x3Plano);
elseif dim==2
A=coef_d12(1);
B=coef_d12(2);
C=coef_d12(3);

valoresX1=0:1:10;
valoresX2=-(A*valoresX1+C)/B;
plot(valoresX1,valoresX2,'red');
end

end