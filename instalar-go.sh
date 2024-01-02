#!/bin/bash
version=$1 #parametro requerido
homegoi=$2 #parametro opcional


if [ $(id -u) -eq 0 ]; then
  echo "Para instalar GO ejecute sin privilegios este script."
  echo "Intenta con el comando: sh instalar-go.sh 'x.x.x'"
  exit 1
fi

#Validar parametro1
if [ -z "$version" ]; then
    echo "ERROR: verifique la versión ingresada y vuelva a intentar."
    exit 1;
fi

#Configuración de usuario

if [ ! -z "$homegoi" ] && [ -d ${homegoi} ]; then
  if [ ! -d ${homegoi}'/bin' ]; then
    mkdir -p $homegoi'/bin'  
  fi
  if [ ! -d ${homegoi}'/src' ]; then
    mkdir -p $homegoi'/src'  
  fi
  if [ ! -d ${homegoi}'/instaladores' ]; then
    mkdir -p $homegoi'/instaladores';  
  fi

  HOMEGO=$homegoi/go;
  HOMEGOI=$homegoi/instaladores;


else
  HOMEGO=$HOME/go;
  HOMEGOI=$HOMEGO/instaladores;

  if [ ! -d ${HOMEGO} ]; then
    mkdir -p $HOMEGO/bin;
    mkdir -p $HOMEGO/src;    
  fi

  if [ ! -d ${HOMEGOI} ]; then
    mkdir $HOMEGOI;
  fi

fi



#Descargar instalador.

sh ./descargar-go.sh $version $HOMEGOI
exit_code=$?
if [ $exit_code = 0 ]; then
  echo "Descarga COMPLETA"

elif [ $exit_code = 1 ]; then
  echo "Descarga FALLIDA"
  exit 1;
fi

#Instalar versión descargada
#goversion=$(go version | cut -d " " -f3 | cut -c 3-);
#goversion=$(go version | cut -d " " -f3 | sed -e 's/^..//');
sudo -k;
echo "Se requieren permisos para continuar, ingrese su credencial sudo.";
#sudo sh ./instalar-act-go.sh ${version} ${HOMEGOI} ${goversion};
sudo sh ./instalar-inst-go.sh ${version} ${HOMEGOI};
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
