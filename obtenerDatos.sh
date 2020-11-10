#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function obtenerDatos {
find $1 -type f -printf '%P,%s\n' 2>/dev/null >archivos.tmp
echo -n > $2
for TMP in $(cat archivos.tmp)
do
    IFS=',' read -ra archivo <<< "$TMP"
    ARCH=${archivo[0]}
    PESO=${archivo[1]}
    MD5=$(sudo md5sum $1/$ARCH | awk '{ print $1 }')
    TIPO=$(sudo file -b --mime-type $1/$ARCH)
    echo $ARCH,$PESO,$MD5,$TIPO >> $2
done

rm archivos.tmp
}

if [ $# -ne 2 ] ; then
  echo -e "=================================================" 
  echo -e "${redColour}PATH de inicio requerido!${endColour}"
  echo -e "${greenColour}Modo de uso: ./obtenerDatos.sh (PATH A COMPARAR) (archivoSalida)${endColour}"
  echo -e "${greenColour}Ejemplo:     ./obtenerDatos.sh /mcom datos.txt${endColour}"
  echo -e "=================================================" && exit 1;
else
  obtenerDatos $1 $2
fi
