noao
digiphot
daophot

string image
string coordst
real fwhmt
real skyt  
real annulust
real dannulust
real aperturet

image="Light_M6_30.0s_Bin1_V_20221001-214200_0011.fit"
coordst="Light_M6_30.0s_Bin1_V_20221001-214200_0011.fit.coo.1"
fwhmt=1.9
skyt=104.0
annulust=9.5
dannulust=3.8
aperturet=2.3

phot(image, coords=coordst, output="default", fwhmpsf=fwhmt, sigma=skyt, annulus=annulust, dannulus=dannulust, apertur=aperturet, veri-)

logout
