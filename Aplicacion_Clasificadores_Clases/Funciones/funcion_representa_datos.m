function funcion_representa_datos(X,Y,espacioCcas,nombresProblema)

[nf nc]=size(espacioCcas);
XClase1=X(Y==1,:);
XClase2=X(Y==2,:);
XClase3=X(Y==3,:);
Clase1=nombresProblema.clases{1};
Clase2=nombresProblema.clases{2};
Clase3=nombresProblema.clases{3};

if nc==2

  hold on, figure, plot(XClase1(:,espacioCcas(1)),XClase1(:,espacioCcas(2)),nombresProblema.simbolos{1},XClase2(:,espacioCcas(1)),XClase2(:,espacioCcas(2)),nombresProblema.simbolos{2},XClase3(:,espacioCcas(1)),XClase3(:,espacioCcas(2)),nombresProblema.simbolos{3});
   xlabel(nombresProblema.descriptores{espacioCcas(1)});
   ylabel(nombresProblema.descriptores{espacioCcas(2)});
   legend(Clase1,Clase2,Clase3);

elseif nc==3

    hold on, figure,plot3(XClase1(:,espacioCcas(1)),XClase1(:,espacioCcas(2)),XClase1(:,espacioCcas(3)),nombresProblema.simbolos{1},XClase2(:,espacioCcas(1)),XClase2(:,espacioCcas(2)),XClase2(:,espacioCcas(3)),nombresProblema.simbolos{2},XClase3(:,espacioCcas(1)),XClase3(:,espacioCcas(2)),XClase3(:,espacioCcas(3)),nombresProblema.simbolos{3});
   xlabel(nombresProblema.descriptores{espacioCcas(1)});
   ylabel(nombresProblema.descriptores{espacioCcas(2)});
   zlabel(nombresProblema.descriptores{espacioCcas(3)});
    legend(Clase1,Clase2,Clase3);

end

end