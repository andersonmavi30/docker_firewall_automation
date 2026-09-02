FROM rockylinux/rockylinux:10

LABEL maintainer="andersonmavi30"
LABEL description="All-in-one firewall automation: Cisco ASA, FortiGate, Palo Alto, Check Point"

ENV PYTHONUNBUFFERED=1 \
    ANSIBLE_FORCE_COLOR=1

# System packages (EPEL is needed for sshpass)
RUN dnf install -y epel-release && \
    dnf install -y \
    python3 \
    python3-pip \
    git \
    curl \
    jq \
    openssh-clients \
    sshpass \
    vim \
    && dnf clean all

# Python dependencies (system-wide)
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

# Ansible collections (system-wide path)
COPY collections.yml /tmp/collections.yml
RUN ansible-galaxy collection install -r /tmp/collections.yml -p /usr/share/ansible/collections

# Non-root user
RUN useradd -m -s /bin/bash fwuser

WORKDIR /app
RUN chown fwuser:fwuser /app

USER fwuser

CMD ["/bin/bash"]
