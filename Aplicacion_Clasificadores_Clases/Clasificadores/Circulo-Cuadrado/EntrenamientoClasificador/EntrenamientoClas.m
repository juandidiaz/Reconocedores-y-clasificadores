load('.\DatosClasificador\Circ-Cuadr.mat');
addpath('..\..\Funciones');

[vectorMedias, matrizCovarianza, probabilidadPriori]=funcion_ajusta_LDA(XoI,YoI);

valoresClases=[1,2];

[YLDA,d]=funcion_aplica_LDA(XoI,vectorMedias,matrizCovarianza,probabilidadPriori,valoresClases);

[d1,d2,d12 coef_d12]=funcion_calcula_hiperPlanoLDA_2Clases_2_3_Dim(XoI,YoI);

save('.\DatosClasificador\FuncionCoeficientes.mat','d12','coef_d12');





