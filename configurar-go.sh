#!/bin/bash
DIR='/usr/local'
GOROOT="${DIR}/go"
GOBIN="${GOROOT}/bin"

if [ -f "/etc/profile.d/go.sh" ]; then
    echo "GO ya se encuentra configurado!";
    exit 1;
fi

cat<<EOT | tee /etc/profile.d/go.sh
export PATH=${PATH}:${GOBIN}
EOT

chmod +x /etc/profile.d/go.sh;

source /etc/profile.d/go.sh;
go version;

echo "Finaliza correctamente la configuración de GO.";
exit 0;