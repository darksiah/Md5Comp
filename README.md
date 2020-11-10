# Md5Comp

Instalacion

-crear venv en directorio raiz (si no esta creado)

virtualenv venv

-Instalar dependencias de python

pip install -r requeriments.txt

Uso

Ejecutar el comando obtenerData para el directorio origen a comparar

./obtenerData (directorio a examinar) (Archivo de salida)

ej.

./obtenerData /etc datos1.txt

Ejecutar el comando obtenerData nuevamente en el directorio destino a comparar

./obtenerData (directorio a examinar) (Archivo de salida)

ej.
./obtenerData /etc datos1.txt

Ejecutar compararWEB

./compararWEB.sh

Acceder via Url

http://(IP donde se corrio el comparador):5000
