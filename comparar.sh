#!/bin/bash


function comparador {
echo ARCHIVO,MD5ORI,MD5DEST,PESOORI,PESODEST,TIPOARCH,RESBUS,LINORI,LINENC > comparativa.csv
echo [ > comparativa.json

for TMP in $(cat $1)
do
    IFS=',' read -ra archivo <<< "$TMP"
    ARCH=${archivo[0]}
    PESOORI=${archivo[1]}
    MD5ORI=${archivo[2]}
    TIPO=${archivo[3]}
    RESBUS=$(grep $ARCH, $2)
    MD5DEST=$(cut -d , -f 3 <<< "$RESBUS")
    PESODEST=$(cut -d , -f 2 <<< "$RESBUS")
    #echo ORI $MD5ORI
    #echo DEST $MD5DEST
    echo $ARCH
    echo $RESBUS
    echo ========

    if [[ -z "$RESBUS" ]]
    then
      #echo "El archivo $ARCH no fue encontrado"
      echo $ARCH,$MD5ORI,0,$PESOORI,0,$TIPO,NOENC,\"$TMP\",\"$RESBUS\" >> comparativa.csv
      echo "{\"ARCHIVO\": \"$ARCH\" ,\"MD5ORI\": \"$MD5ORI\", \"MD5DEST\": \"-\", \"PESOORI\": $PESOORI, \"PESODEST\": 0, \"TIPOARCH\": \"$TIPO\", \"RESBUS\": \"NOENC\", \"LINORI\": \"$TMP\", \"LINENC\": \"$RESBUS\"}," >> comparativa.json
    else
      if [[ "$MD5ORI" == "$MD5DEST" ]]
      then
        #echo "El archivo $ARCH fue encontrado y tiene el mismo MD5"
        echo $ARCH,$MD5ORI,$MD5DEST,$PESOORI,$PESODEST,$TIPO,MD5OK,\"$TMP\",\"$RESBUS\" >> comparativa.csv
        echo "{\"ARCHIVO\": \"$ARCH\" ,\"MD5ORI\": \"$MD5ORI\", \"MD5DEST\": \"$MD5DEST\", \"PESOORI\": $PESOORI, \"PESODEST\": $PESODEST, \"TIPOARCH\": \"$TIPO\", \"RESBUS\": \"MD5OK\", \"LINORI\": \"$TMP\", \"LINENC\": \"$RESBUS\"}," >> comparativa.json
      else
        #echo "El archivo $ARCH fue encontrado pero tiene distinto MD5"
        echo $ARCH,$MD5ORI,$MD5DEST,$PESOORI,$PESODEST,$TIPO,MD5DIF,\"$TMP\",\"$RESBUS\" >> comparativa.csv
        echo "{\"ARCHIVO\": \"$ARCH\" ,\"MD5ORI\": \"$MD5ORI\", \"MD5DEST\": \"$MD5DEST\", \"PESOORI\": $PESOORI, \"PESODEST\": $PESODEST, \"TIPOARCH\": \"$TIPO\", \"RESBUS\": \"MD5DIF\", \"LINORI\": \"$TMP\", \"LINENC\": \"$RESBUS\"}," >> comparativa.json
      fi
    fi
done

sed -i '$s/,$//' comparativa.json
echo ] >> comparativa.json

}

comparador $1 $2
