#Código para unir las tablas generadas en match.py de STILTS, esto para que quede la información de cada estrella del máster
#identificada en todos los cuadros en un solo archivo.

import pandas as pd
import numpy as np
import subprocess
import os
from tqdm import tqdm

def merge_csvs(input_folder, output_file, names):
    # Obtener la lista de archivos CSV en la carpeta de entrada
    with open(names, 'r') as file:
    	lines = file.readlines()
    	csv_files = [line.strip() for line in lines]
 
    	
    print(csv_files)

    # Inicializar el DataFrame con el primer archivo CSV
    df_final = pd.read_csv(os.path.join(input_folder, csv_files[0]))
    columnas_deseadas = ['ID_2','XCENTER_2','YCENTER_2','FLUX_2','MAG_2','MERR_2']

    # Iterar sobre los archivos restantes y concatenarlos
    for i, csv_file in tqdm(enumerate(csv_files[1:], start=1)):
        # Leer el CSV actual
        df_current = pd.read_csv(os.path.join(input_folder, csv_file))
        df_current = df_current[columnas_deseadas]

        # Renombrar las columnas del CSV actual con un sufijo
        suffix = f'_{i}'
        df_current = df_current.rename(columns={col: f'{col}{suffix}' for col in columnas_deseadas})

        # Agregar las columnas del CSV actual al DataFrame final con sufijo
        df_final = pd.concat([df_final, df_current], axis=1)

    # Guardar el DataFrame final en un nuevo archivo CSV
    df_final.to_csv(output_file, index=False)

# Especifica la carpeta de entrada y el archivo de salida
input_folder = os.getcwd()
output_file = 'resultado.csv'
names = 'lstcsv.dat'
# Llama a la función para realizar la concatenación
merge_csvs(input_folder, output_file, names)
