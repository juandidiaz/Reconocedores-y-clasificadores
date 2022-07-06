function centroides=funcion_calcula_centroides(IEtiq,N)

centroides=zeros(N-1,2);

    for i=1:N-1
    [f,c]=find(IEtiq==i);
    fmedia=mean(f);
    cmedia=mean(c);
    centroides(i,1)=fmedia;
    centroides(i,2)=cmedia;
    end




end