FROM ubuntu:22.04
LABEL maintainer="Fernando Aleman"

# Avoid interactive prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Packages to install with pip3
ENV PIP_PACKAGES="ansible"

# Install system dependencies and clean up to reduce image size
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  apt-utils build-essential locales libffi-dev libssl-dev libyaml-dev \
  python3-dev python3-setuptools python3-pip python3-yaml \
  software-properties-common rsyslog systemd systemd-cron sudo iproute2 \
  && apt-get clean \
  && rm -Rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# Disable imklog to prevent rsyslog from trying to access kernel logs (not available in containers)
RUN sed -i '/^module(load="imklog"/ s/^/#/' /etc/rsyslog.conf

# Generate locale to prevent warnings and ensure consistent encoding
RUN locale-gen en_US.UTF-8

# Install Python packages
RUN pip3 install $PIP_PACKAGES

# Set up a default Ansible inventory with local execution
RUN mkdir -p /etc/ansible \
  && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# Remove unnecessary systemd units not needed in a container
RUN rm -f /lib/systemd/system/systemd*udev* /lib/systemd/system/getty.target

# Declare volumes needed by systemd and runtime
VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]

# Start systemd as the main process
CMD ["/lib/systemd/systemd"]
