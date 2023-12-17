#!/bin/bash

if [ $EUID -ne 0 ]; then
  echo "Se requieren permisos ROOT para actualizar GO"
  echo "Intenta con el comando: sudo sh actualizar-go.sh"
  exit 1
fi

sudo -k
