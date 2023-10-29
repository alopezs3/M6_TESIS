noao
digiphot
daophot
string image
real fwhmt       # Esto es un ejemplo, el valor será reemplazado en el script de shell
real skyt       # Esto es un ejemplo, el valor será reemplazado en el script de shell
int thresholdt
image="Light_M6_30.0s_Bin1_V_20221001-214200_0011.fit"
fwhmt=1.9
skyt=104.0
thresholdt=6
daofind(image,"default",fwhm=fwhmt,sigma=skyt,threshold=thresholdt,veri-)
logout
