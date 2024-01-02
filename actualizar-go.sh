#!/bin/bash
version=$1

if [ $(id -u) -eq 0 ]; then
  echo "Para actualizar GO ejecute sin privilegios este script."
  echo "Intenta con el comando: sh actualizar-go.sh 'x.x.x'"
  exit 1
fi

#Configuración de usuario

HOMEGO=$HOME/go;
HOMEGOI=$HOMEGO/instaladores;

if [ ! -d ${HOMEGO} ]; then
  mkdir -p $HOME/go/{bin,src,instaladores}
fi

if [ ! -d ${HOMEGOI} ]; then
  mkdir $HOMEGOI;
fi


#Descargar instalador.

sh ./descargar-go.sh $version
exit_code=$?
if [ $exit_code = 0 ]; then
  echo "Descarga COMPLETA"

elif [ $exit_code = 1 ]; then
  echo "Descarga FALLIDA"
  exit 1;
fi


#Instalar versión descargada
goversion=$(go version | cut -d " " -f3 | cut -c 3-);
#goversion=$(go version | cut -d " " -f3 | sed -e 's/^..//');
sudo -k;
echo "Se requieren permisos para continuar, ingrese su credencial sudo.";
sudo sh ./instalar-act-go.sh ${version} ${HOMEGOI} ${goversion};
exit_code=$?
if [ $exit_code = 0 ]; then
  echo "Instalación COMPLETA."
else
  echo "Instalación FALLIDA."
  exit 1;
fi

sudo -k
echo "Reinicia tu sesión de usuario para verificar la instalación o actualización!";
exit 0;