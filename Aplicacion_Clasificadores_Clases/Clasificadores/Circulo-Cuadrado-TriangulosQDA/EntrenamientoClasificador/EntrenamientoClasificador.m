load('.\DatosClasificador\Circulo-Cuadrado-Triangulo.mat');
addpath('..\..\Funciones');

[vectorMedias, matricesCovarianzas,probabilidadPriori]=funcion_ajusta_QDA(XoI,YoI);

valoresClases=[1,2,3];

[YQDA d]=funcion_aplica_QDA(XoI,vectorMedias,matricesCovarianzas,probabilidadPriori,valoresClases);

d12=d(1,1,1)-d(1,1,2);
d23=d(1,1,2)-d(1,1,3);
d13=d(1,1,1)-d(1,1,3);

save('.\DatosClasificador\Funciones','d12','d23','d13');
