#!/bin/bash
version=$1
homegoi=$2

if [ $EUID -ne 0 ]; then
  echo "Se requieren permisos ROOT para instalar GO"
  echo "Intenta con el comando: sudo sh instalar-go.sh"
  exit 1
fi

#verificar si existe alguna versión instalada

versioni=$(go version | cut -d " " -f3);


DIR='/usr/local'
GOROOT="${DIR}/go"
GOBIN="${GOROOT}/bin"

# Verificar si existe una versión anterior

if [ -d ${GOROOT} ]; then
  rm -fr ${GOROOT:-/usr/local/go}
fi

tar xzf - -C ${BASE}

sudo -k
