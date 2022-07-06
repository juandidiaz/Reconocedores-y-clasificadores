function [g_MinEntreMax,gMax1,gMax2]=funcion_MinEntreMax(Id)
h=imhist(id);

[hMax g1]=max(h);

metrica=zeros(256,1);

for g=1:256
metrica(g)=h(g)*(g-g1)^2;
end

[metricaMax,g2]=max(metrica);

hmod=h;

aux=g1;

if g1>g2
g1=g2;
g2=aux;
end

hmod(1:g1)=hMax;
hmod(g2:256)=hMax;

[valorMin,T]=min(hmod);
T=T-1

end