#!/bin/bash
version=$1

if [ $EUID -eq 0 ]; then
  echo "Para actualizar GO ejecute sin privilegios este script."
  echo "Intenta con el comando: sh actualizar-go.sh 'x.x.x'"
  echo "Si esto no funciona, asigne permisos de ejecución al script: chmod +x actualizar-go.sh"
  exit 1
fi

HOMEGO=$HOME/go

if [! -d ${HOMEGO} ]; then
  mkdir -p $HOME/go/{bin,src,instaladores}
fi

if [! -d ${HOMEGO/instaladores} ]; then
  mkdir $HOME/go/instaladores
fi

#Descargar instalador.
if [ -z "$version" ]; then
archi="go1.21.5.linux-amd64.tar.gz"
else
archi="go${version}.linux-amd64.tar.gz"
fi

URL="https://go.dev/dl/"$archi
wget -P $HOME/go/instaladores ${URL}

if[! -f $HOME/go/instaladores/$archi]; then
  echo "ERROR: en la descarga del instalador, verifique la versión ingresada y vuelva a intentar"
  exit 1
fi


#Instalar versión descargada

sh instalar-go.sh "~/go/instaladores"

URL="https://go.dev/dl/go1.21.5.linux-amd64.tar.gz"
DIR='/usr/local'
GOROOT="${DIR}/go"
GOBIN="${GOROOT}/bin"

# Verificar si existe una versión anterior
# Si existe, empaquetarla y almacenarla en el DIR, luego eliminar
if [ -d ${GOROOT} ]; then
  rm -fr ${GOROOT:-/usr/local/go}
fi

wget ${URL} -O - | tar xzf - -C ${BASE}


cat<<EOT | tee /etc/profile.d/golang.sh
# Configurar entorno para Golang
export PATH=${GOBIN}:${PATH}
EOT

chmod +x /etc/profile.d/golang.sh

source /etc/profile.d/golang.sh

go version

echo "Reinicia tu sesión de usuario para verificar la actualización!"