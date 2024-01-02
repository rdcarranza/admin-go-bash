#!/bin/bash

version=$1; #parametro requerido
homegoi=$2; #parametro opcional

#Verificar parametro1
if [ -z "$version" ]; then
    echo "ERROR: en la descarga del instalador, verifique la versión ingresada y vuelva a intentar"
    exit 1;
else
    archi="go${version}.linux-amd64.tar.gz"
fi


#Verificar parametro2

if [ -z "$homegoi" ]; then
    diri=$HOME/go/instaladores;
else
    diri=$homegoi;
fi

#diri=$HOME/go/instaladores;

URL="https://go.dev/dl/"$archi;
wget -N -P $diri ${URL};

diri_archi=$diri"/"$archi;
#echo $diri_archi;
if [ -f $diri_archi ];
then
    echo "Descarga finalizada correctamente!"    
else
    echo "ERROR: en la descarga del instalador, verifique la versión ingresada y vuelva a intentar"
    exit 1;
fi

exit 0;
