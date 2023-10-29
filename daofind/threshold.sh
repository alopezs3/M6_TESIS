#!/bin/bash

#IMFWSK.txt contiene el nombre de las imagenes, y el valor asociado de fwhm y nivel de cielo para cada imagen.
file_with_image_info="IMFWSK.txt"

# Define la lista de threshold
threshold_values="3 4 5 6 7 8 9 10 11 12 13 14 15" 

#líneas que se toman para generar las curvas
total_lines_to_process=10

# Calcula el salto entre líneas equiespaciadas
paso=$(( $(wc -l < "$file_with_image_info") / $total_lines_to_process ))

echo "$paso"
i=0
# Leer el archivo de texto línea por línea
while read -r image_file fwhm sky; do
  # Incrementa el contador de líneas leídas
  if (( i % paso == 0 )); then
   # Itera a través de los umbrales	
   for threshold_val in $threshold_values; do
    # Imprime información sobre la imagen y el umbral actual
    echo "Procesando imagen: $image_file, FWHM: $fwhm, Sky: $sky, Umbral: $threshold_val, Linea:$i"
    
    # Reemplaza los valores en el archivo de control .cl
    
    sed -i "s/^image=.*/image=\"$image_file\"/g" pdaofind.cl
    sed -i "s/^thresholdt=.*/thresholdt=$threshold_val/g" pdaofind.cl
    sed -i "s/^fwhmt=.*/fwhmt=$fwhm/g" pdaofind.cl
    sed -i "s/^skyt=.*/skyt=$sky/g" pdaofind.cl
    
    # Ejecuta el archivo de control con IRAF
    cl < pdaofind.cl 
    done
   fi
  
  ((i++))

done < "$file_with_image_info"

