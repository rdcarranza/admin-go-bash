# admin-go-bash

> Scripts en Bash para instalar y actualizar **Go** en Linux, o simplemente para saltar entre versiones.

![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white)
![Go](https://img.shields.io/badge/Go-cualquier%20versi%C3%B3n-00ADD8?logo=go&logoColor=white)
![Platform](https://img.shields.io/badge/Linux-amd64-FCC624?logo=linux&logoColor=black)
![License](https://img.shields.io/badge/license-AGPL--3.0-blue)

---

## Características

- Instala cualquier versión de Go indicando solo el número (`1.21.5`).
- Actualiza o cambia de versión reemplazando la instalada, con confirmación previa.
- Descarga el `.tar.gz` oficial desde [go.dev/dl](https://go.dev/dl/).
- Crea el directorio de trabajo (`bin`, `src`, `instaladores`) en `$HOME/go`, o en el que elijas.
- Configura el `PATH` para todos los usuarios del sistema.
- Pide privilegios (`sudo`) solo en el paso que los necesita.

## Requisitos

- Linux `amd64` (x86_64)
- `bash`, `wget`, `tar` y `sudo`
- Un usuario con permisos de `sudo`
- Conexión a internet

## Inicio rápido

```bash
git clone https://github.com/rdcarranza/admin-go-bash.git
cd admin-go-bash
bash instalar-go.sh 1.21.5
```

> **Importante:** ejecutá los scripts desde la carpeta del repositorio, porque se llaman entre sí con rutas relativas. Y hacelo **sin** `sudo`: los scripts piden la contraseña solo cuando hace falta.

## Uso

### Instalación

```bash
bash instalar-go.sh <version>
```

Crea automáticamente el directorio de trabajo en `$HOME/go`.

```bash
bash instalar-go.sh 1.21.5
```

### Instalación con directorio de trabajo propio

```bash
bash instalar-go.sh <version> <dir_trabajo>
```

```bash
bash instalar-go.sh 1.21.5 /home/usuario/go
```

### Actualización

```bash
bash actualizar-go.sh <version>
```

```bash
bash actualizar-go.sh 1.22.1
```

Si la versión pedida ya está instalada, el script avisa y no cambia nada. Si es distinta, pregunta antes de eliminar la anterior (Enter o `s`/`si` confirman, cualquier otra respuesta cancela).

### Verificar

Reiniciá la sesión de usuario (o abrí una terminal nueva) y ejecutá:

```bash
go version
```

## Estructura del proyecto

| Script | Descripción | Requiere root |
| --- | --- | :---: |
| `instalar-go.sh` | Punto de entrada para una instalación nueva. | No |
| `actualizar-go.sh` | Punto de entrada para actualizar o cambiar de versión. | No |
| `descargar-go.sh` | Descarga el `.tar.gz` de la versión indicada. | No |
| `instalar-inst-go.sh` | Instala Go (instalación nueva). Lo invoca `instalar-go.sh`. | Sí |
| `instalar-act-go.sh` | Reemplaza la versión instalada. Lo invoca `actualizar-go.sh`. | Sí |
| `configurar-go.sh` | Crea `/etc/profile.d/go.sh` para agregar Go al `PATH`. | Sí |

### Flujo

```text
instalar-go.sh ──► descargar-go.sh
       │
       └─ (sudo) ─► instalar-inst-go.sh ──► configurar-go.sh

actualizar-go.sh ─► descargar-go.sh
       │
       └─ (sudo) ─► instalar-act-go.sh ───► configurar-go.sh
```

## Rutas utilizadas

| Qué | Dónde |
| --- | --- |
| Go instalado | `/usr/local/go` |
| Configuración del `PATH` | `/etc/profile.d/go.sh` |
| Instaladores descargados | `$HOME/go/instaladores` |
| Directorio de trabajo | `$HOME/go` (`bin`, `src`) |

## Solución de problemas

**`source: not found` o `read: Illegal option -p`**
Estás ejecutando los scripts con `sh` en un sistema donde `sh` es `dash` (Debian, Ubuntu). Usá `bash script.sh`.

**`ERROR: en la descarga del instalador`**
Verificá que la versión exista en [go.dev/dl](https://go.dev/dl/) y que tengas conexión.

**`No such file or directory: ./descargar-go.sh`**
Ejecutá los scripts desde la carpeta del repositorio.

**`go: command not found` después de instalar**
Reiniciá la sesión o ejecutá `source /etc/profile.d/go.sh`.

## Licencia

Distribuido bajo la licencia **AGPL-3.0**. Ver [LICENSE](LICENSE).

## Windows

¿Usás Windows? Hay una versión equivalente en PowerShell: **admin-go-powershell**.