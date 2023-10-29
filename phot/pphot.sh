#!/bin/bash

#Lee archivo que contiene IMAGEN  COORD  FWHM   SKY ANNULUS DANNULUS APERTURE.
file_with_image_info="phot.txt"


# Leer el archivo de texto línea por línea
while read -r image_file coord_file fwhm sky annulus dannulus aperture; do

    # Imprime información sobre la imagen
    echo "Procesando imagen: $image_file, coord: $coord_file"
    
    # Reemplaza los valores en el archivo de control pdaofind.cl
    
    sed -i "s/^image=.*/image=\"$image_file\"/g" pphot.cl
    sed -i "s/^coordst=.*/coordst=\"$coord_file\"/g" pphot.cl
    sed -i "s/^fwhmt=.*/fwhmt=$fwhm/g" pphot.cl
    sed -i "s/^skyt=.*/skyt=$sky/g" pphot.cl
    sed -i "s/^annulust=.*/annulust=$annulus/g" pphot.cl
    sed -i "s/^dannulust=.*/dannulust=$dannulus/g" pphot.cl
    sed -i "s/^aperturet=.*/aperturet=$aperture/g" pphot.cl
    # Ejecuta el archivo de control con IRAF 
    cl < pphot.cl 

done < "$file_with_image_info"

