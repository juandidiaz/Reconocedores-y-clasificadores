function T=funcion_ISODATA(I,umbralParada)

while(true)
gIni=1;
gFin=256;
gMean=calcula_valor_medio_region_histograma(h,gIni,gFin);

UmbralParada=0;

T=calcula_valor_medio_region_histograma(h,gIni,gFin);

gIni=1;
gFin=round(T);
gMean1=calcula_valor_medio_region_histograma(h,gIni,gFin);

gIni=round(T)+1;
gFin=256;
gMean2=calcula_valor_medio_region_histograma(h,gIni,gFin);

newT=mean([gMean1 gMean2]);

if abs(T-newT)
    break;
else
T=newT;
end
end
T=T-1
end