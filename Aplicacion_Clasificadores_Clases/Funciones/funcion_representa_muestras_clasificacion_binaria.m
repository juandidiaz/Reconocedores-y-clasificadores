function funcion_representa_muestras_clasificacion_binaria(X,Y,nombresProblema,espacioCcas,valoresClases)
valoresClases=unique(Y);
numeroClases=length(valoresClases);
descriptores=size(X,2);

nombreEspacio=nombresProblema.descriptores;
simbolos=nombresProblema.simbolos;
leyenda=nombresProblema.clases;
for i=1:numeroClases
    Xaux=X(Y==valoresClases(i),:);
    if descriptores==2
        plot(Xaux(:,1),Xaux(:,2),simbolos{i});
        xlabel(nombreEspacio{espacioCcas(1)}),
        ylabel(nombreEspacio{espacioCcas(2)});
        hold on;
    else
        plot3(Xaux(:,1),Xaux(:,2),Xaux(:,3),simbolos{i});
        xlabel(nombreEspacio{espacioCcas(1)}),
        ylabel(nombreEspacio{espacioCcas(2)});
        zlabel(nombreEspacio{espacioCcas(3)});
        hold on;
    end
end
legend('HiperPlano',leyenda{valoresClases(2)},leyenda{valoresClases(1)});

end