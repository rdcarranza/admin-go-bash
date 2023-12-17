#!/bin/bash

version=$1;
if [ -z "$version" ]; then
archi="go1.21.5.linux-amd64.tar.gz"
else
archi="go${version}.linux-amd64.tar.gz"
fi

diri=$HOME/go/instaladores;

URL="https://go.dev/dl/"$archi;
wget -N -P $diri ${URL};

diri_archi=$diri"/"$archi;
#echo $diri_archi;
if [ -f $diri_archi ];
then
    echo "Descarga finalizada correctamente!"    
else
    echo "ERROR: en la descarga del instalador, verifique la versión ingresada y vuelva a intentar"
    exit 1
fi

