#Este script ejecuta daofind para todas las imágenes de una noche con el valor threshold seleccionado.
#!/bin/bash

file_with_image_info="IMFWSK.txt"

# Define el valor de threshold óptimo manualmente.
threshold_val="6" 

while read -r image_file fwhm sky; do

    # Imprime información sobre la imagen y el umbral actual
    echo "Procesando imagen: $image_file, FWHM: $fwhm, Sky: $sky, Umbral: $threshold_val, Linea:$i"
    
    # Reemplaza los valores en el archivo de control .cl
    
    sed -i "s/^image=.*/image=\"$image_file\"/g" pdaofind.cl
    sed -i "s/^thresholdt=.*/thresholdt=$threshold_val/g" pdaofind.cl
    sed -i "s/^fwhmt=.*/fwhmt=$fwhm/g" pdaofind.cl
    sed -i "s/^skyt=.*/skyt=$sky/g" pdaofind.cl
    
    # Ejecuta el archivo de control con IRAF
    cl < pdaofind.cl 

done < "$file_with_image_info"

ls *coo* > coords.lst
mkdir Coords
mv *coo* Coords

