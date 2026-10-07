#!/bin/bash
version=$1

if [ $(id -u) -eq 0 ]; then
  echo "Para actualizar GO ejecute sin privilegios este script."
  echo "Intenta con el comando: sh actualizar-go.sh 'x.x.x'"
  exit 1
fi

case "$(uname -s)" in
    Linux)
        GOOS="linux"
        ;;
    Darwin)
        GOOS="darwin"
        ;;
    FreeBSD)
        GOOS="freebsd"
        ;;
    *)
        echo "Sistema operativo no soportado: $(uname -s)" >&2
        exit 1
        ;;
esac

case "$(uname -m)" in
    x86_64)
        GOARCH=amd64
        ;;
    aarch64)
        GOARCH=arm64
        ;;
    armv6l)
        GOARCH=arm
        GOARM=6
        ;;
    armv7l)
        GOARCH=arm
        GOARM=7
        ;;
    ppc64le)
        GOARCH=ppc64le
        ;;
    s390x)
        GOARCH=s390x
        ;;
    riscv64)
        GOARCH=riscv64
        ;;
    *)
        echo "Arquitectura no soportada: $(uname -m)" >&2
        exit 1
        ;;
esac

echo "Sistema : $(uname -s)"
echo "Machine : $(uname -m)"
echo "GOOS       : $GOOS"
echo "GOARCH  : $GOARCH"
echo "GOARM    : ${GOARM:-}"

#[[ -n "${GOARM:-}" ]] && echo "GOARM   : $GOARM"

#Validar parametro1
if [ -z "$version" ]; then
  echo "ERROR: verifique la versión ingresada y vuelva a intentar."
  exit 1;
else
  if [ "${GOARCH}" == "arm" ]; then
      archi="${version}.${GOOS}-armv${GOARM}l"
  else
      archi="${version}.${GOOS}-${GOARCH}"
  fi
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

sh ./descargar-go.sh $archi $HOMEGOI
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
sudo sh ./instalar-act-go.sh ${version} ${archi} ${HOMEGOI} ${goversion};
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