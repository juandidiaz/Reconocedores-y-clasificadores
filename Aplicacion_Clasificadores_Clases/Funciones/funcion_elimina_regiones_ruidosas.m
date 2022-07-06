function IbinFilt=funcion_elimina_regiones_ruidosas(Ibin)

[nf nc]=size(Ibin);

numPix=nf*nc;

numPix01=round((numPix*0.1)/100);

stats=regionprops(Ibin,'Area');
Areas=cat(1,stats.Area);
areaMayor=round(max(Areas)/5);

%IbinFilt=bwareaopen(Ibin,numPix01);
IbinFilt=bwareaopen(Ibin,areaMayor);

end