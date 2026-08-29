# docker_firewall_automation

🇪🇸 [Versión en Español](README.es.md)

All-in-one Docker container with everything needed to automate multi-vendor
firewall management:

**Cisco ASA · FortiGate · Palo Alto · Check Point**

Same philosophy as
[docker_network_automation](https://gitlab.com/andersonmavi30/docker_network_automation),
but focused on firewalls.

## What is it?

A Docker image that bundles the full automation stack in one place: Ansible with
each vendor's official collections, Python with network SDKs and libraries, and
support utilities. Nothing to install on your machine: build the image, mount
your playbooks/scripts as a volume, and run.

## Supported vendors

| Vendor | Access method | Included tools |
|---|---|---|
| **Cisco ASA** | SSH / REST API | `netmiko`, Ansible collection `cisco.asa` |
| **FortiGate** | REST API | `fortiosapi`, Ansible collection `fortinet.fortios` |
| **Palo Alto** | PAN-OS XML API | `pan-os-python`, `pan-python`, collection `paloaltonetworks.panos` |
| **Check Point** | Management API | `cp_mgmt_api_python_sdk`, collection `check_point.mgmt` |

## Container contents (planned)

- **Python 3** + `pip`
- **Ansible** + collections for all 4 vendors
- **Network libraries**: `netmiko`, `napalm`, `paramiko`
- **Utilities**: `requests`, `jinja2`, `pyyaml`, `git`, `curl`, `jq`, `openssh-client`

## Usage (draft)

```bash
# Build the image
docker build -t docker_firewall_automation .

# Run the container mounting your playbooks and inventory files
docker run -it --rm \
  -v $(pwd)/playbooks:/app/playbooks \
  -v $(pwd)/inventory:/app/inventory \
  docker_firewall_automation
```

## Git workflow

Standard flow for **every change** (GitLab = main repo, GitHub = backup):

```bash
# 1. Create a branch and switch to it
git checkout -b feature/my-change

# 2. Edit files, then stage and commit
git add .
git commit -m "feat: describe the change"

# 3. Push the branch to GitLab and open a Merge Request
git push -u gitlab feature/my-change

# 4. After the MR is merged, sync local main (fast-forward only)
git checkout main
git pull --ff-only

# 5. Push main to the GitHub backup
git push github main

# 6. Delete the local branch and prune deleted remote branches
git branch -d feature/my-change
git fetch --prune
```

## Project structure (planned)

```text
docker_firewall_automation/
├── Dockerfile
├── requirements.txt       # Python libraries
├── requirements.yml       # Ansible collections
├── ansible.cfg
├── playbooks/             # Example playbooks
├── scripts/               # Helper scripts
└── README.md
```

## Repositories

| Role | Platform | Git remote |
|---|---|---|
| Main | GitLab | `gitlab` |
| Backup | GitHub | `github` |

## License

MIT
