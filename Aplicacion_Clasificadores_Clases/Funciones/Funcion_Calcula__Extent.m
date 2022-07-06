function Extent=Funcion_Calcula_Extent(Matriz_Binaria)

Matriz_Binaria=Funcion_Centra_Objeto(Matriz_Binaria);
ExtentMatriz=zeros(72,1);
contador=1;
for i=0:5:355
    Matriz_aux=imrotate(Matriz_Binaria,i);
    [f,c]=find(Matriz_aux);
    fmin=min(f);fmax=max(f);
    cmin=min(c);cmax=max(c);

    fmin=fmin-0.5;
    fmax=fmax+0.5;
    cmin=cmin-0.5;
    cmax=cmax+0.5;

    numPixBB=(cmax-cmin)*(fmax-fmin);
    numPixObjeto=sum(Matriz_Binaria(:));
    ExtentMatriz(contador)=numPixObjeto/numPixBB;
    
    contador=contador+1;
end
Extent=max(ExtentMatriz);


end