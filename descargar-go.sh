#!/bin/bash

version=$1; #parametro requerido
homegoi=$2; #parametro opcional
#OS="$(uname -s | tr '[:upper:]' '[:lower:]')"

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

#Verificar parametro1
if [ -z "$version" ]; then
    echo "ERROR: en la descarga del instalador, verifique la versión ingresada y vuelva a intentar"
    exit 1;
else
    #archi="go${version}.linux-amd64.tar.gz"
    if [[ "${GOARCH}" == "arm" ]]; then
        archi="go${version}.${GOOS}-armv${GOARM}l.tar.gz"
    else
        archi="go${version}.${GOOS}-${GOARCH}.tar.gz"
    fi
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
