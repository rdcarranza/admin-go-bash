# admin-go-bash
### Script para facilitar la instalación y actualización de GO en entornos Linux. O simplemente, para saltar entre versiones.

## Ejecución - Actualización
```
$ sh actualizar-go.sh <version>
```

**Ejemplo:**
```
$ sh actualizar-go.sh 1.21.5
```

## Ejecución - Instalación
```
$ sh instalar-go.sh <version>
```

##### De esta manera se crea automaticamente el directorio de trabajo en $HOME/go.

**Ejemplo:**
```
$ sh instalar-go.sh 1.21.5 
```



## Ejecución - Instalación (Con directorio de trabajo)

```
$ sh instalar-go.sh <version> <dir_trabajo>
```

**Ejemplo:**
```
$ sh instalar-go.sh 1.21.5 /home/usuario/go
```