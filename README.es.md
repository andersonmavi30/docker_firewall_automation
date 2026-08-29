# docker_firewall_automation

🇺🇸 [English version](README.md)

Contenedor Docker **todo en uno** con las herramientas necesarias para
automatizar la administración de firewalls multi-vendor:

**Cisco ASA · FortiGate · Palo Alto · Check Point**

Misma filosofía que
[docker_network_automation](https://gitlab.com/andersonmavi30/docker_network_automation),
pero orientado a firewalls.

## ¿Qué es?

Una imagen Docker que empaqueta en un solo lugar todo el stack de automatización:
Ansible con las colecciones oficiales de cada fabricante, Python con los SDKs y
librerías de red, y utilidades de soporte. Sin instalar nada en tu máquina:
construyes la imagen, montas tus playbooks/scripts como volumen y ejecutas.

## Vendors soportados

| Vendor | Método de acceso | Herramientas incluidas |
|---|---|---|
| **Cisco ASA** | SSH / REST API | `netmiko`, colección Ansible `cisco.asa` |
| **FortiGate** | API REST | `fortiosapi`, colección Ansible `fortinet.fortios` |
| **Palo Alto** | PAN-OS XML API | `pan-os-python`, `pan-python`, colección `paloaltonetworks.panos` |
| **Check Point** | Management API | `cp_mgmt_api_python_sdk`, colección `check_point.mgmt` |

## Contenido del contenedor (previsto)

- **Python 3** + `pip`
- **Ansible** + colecciones de los 4 vendors
- **Librerías de red**: `netmiko`, `napalm`, `paramiko`
- **Utilidades**: `requests`, `jinja2`, `pyyaml`, `git`, `curl`, `jq`, `openssh-client`

## Uso (borrador)

```bash
# Construir la imagen
docker build -t docker_firewall_automation .

# Ejecutar el contenedor montando tus playbooks y archivos de inventario
docker run -it --rm \
  -v $(pwd)/playbooks:/app/playbooks \
  -v $(pwd)/inventory:/app/inventory \
  docker_firewall_automation
```

## Flujo de trabajo git

Flujo estándar para **cada cambio** (GitLab = repo principal, GitHub = respaldo):

```bash
# 1. Crear una rama y saltar a ella
git checkout -b feature/mi-cambio

# 2. Editar archivos, preparar y commitear
git add .
git commit -m "feat: describe el cambio"

# 3. Subir la rama a GitLab y abrir un Merge Request
git push -u gitlab feature/mi-cambio

# 4. Cuando el MR esté mergeado, sincronizar main local (solo fast-forward)
git checkout main
git pull --ff-only

# 5. Subir main al respaldo en GitHub
git push github main

# 6. Borrar la rama local y limpiar ramas remotas eliminadas
git branch -d feature/mi-cambio
git fetch --prune
```

## Estructura del proyecto (prevista)

```text
docker_firewall_automation/
├── Dockerfile
├── requirements.txt       # Librerías Python
├── requirements.yml       # Colecciones Ansible
├── ansible.cfg
├── playbooks/             # Playbooks de ejemplo
├── scripts/               # Scripts de apoyo
└── README.md
```

## Repositorios

| Rol | Plataforma | Remoto git |
|---|---|---|
| Principal | GitLab | `gitlab` |
| Respaldo | GitHub | `github` |

## Licencia

MIT
