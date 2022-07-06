function [gMean,numPix]=calcula_valor_medio_region_histograma(h,gIni,gFin)

gIni=round(gIni);
gFin=round(gFin);

numPix=sum(h(gIni:gFin));

if numPix>0
aux=0;

for g=gIni:gFin
aux=aux+g*h(g);
end
gMean=(aux/numPix);
else
    gMean=[];
end


end