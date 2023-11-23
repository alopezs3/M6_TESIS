import pandas as pd
import numpy as np
import subprocess
import os
from tqdm import tqdm

coords = pd.read_csv('refcoords.dat', sep='\s+', names=['x', 'y'])
Ref1 = 2286.54164632
Ref2 = 2454.822631836

diffx = Ref1 - coords.x
diffy = Ref2 - coords.y

with open('diff.dat', 'w') as archivo:
    for i in range(len(diffx)):
        archivo.write(f'{diffx[i]}' + '   ' f'{diffy[i]}' +'\n')
        
diff = pd.read_csv('diff.dat', sep='\s+', names=['x', 'y'])
names = pd.read_csv('names.dat', sep='\s+', names=['nombre'])
master = names.nombre[134]
print(master)
outfile = [names.nombre[i].replace('.fit.dat', '.csv') for i in range(len(names))]

for i in tqdm(range(len(names))):
    archivo_in2 = names.nombre[i]
    difx = diff.x[i]
    dify = diff.y[i]
    archivo_out = outfile[i]
    comando_java = f"java -jar stilts.jar tmatch2 ifmt1=ascii ifmt2=ascii in1={master} in2={archivo_in2} matcher=2d values1='XCENTER YCENTER' values2='XCENTER+{difx} YCENTER+{dify}' params='15' omode=out find=best join=1or2 ofmt=csv out={archivo_out}"
    proceso = subprocess.Popen(comando_java, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    salida, error = proceso.communicate()
