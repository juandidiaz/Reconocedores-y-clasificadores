load('.\DatosClasificador\Cuad-Triang.mat');
addpath('..\..\Funciones');

[vectorMedias, matrizCovarianza, probabilidadPriori]=funcion_ajusta_LDA(XoI,YoI);

valoresClases=[2,3];

[YLDA,d]=funcion_aplica_LDA(XoI,vectorMedias,matrizCovarianza,probabilidadPriori,valoresClases);

[d1,d2,d12 coef_d12]=funcion_calcula_hiperPlanoLDA_2Clases_2_3_Dim(XoI,YoI);

funcion_representa_hiperplano_separacion_2_3_Dim(coef_d12,XoI);

save('.\DatosClasificador\FuncionCoeficientes.mat','d12','coef_d12');