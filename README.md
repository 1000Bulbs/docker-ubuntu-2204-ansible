# Docker Ubuntu 22.04 Ansible Test Image

[![Build](https://github.com/1000Bulbs/docker-ubuntu-2204-ansible/actions/workflows/build.yml/badge.svg)](https://github.com/1000Bulbs/docker-ubuntu-2204-ansible/actions/workflows/build.yml) [![Docker pulls](https://img.shields.io/docker/pulls/1000bulbs/docker-ubuntu-2204-ansible)](https://hub.docker.com/r/1000bulbs/docker-ubuntu-2204-ansible/)

Ubuntu 22.04 docker container for testing Ansible roles and playbooks.

## Tags

- `latest`: Latest stable version of Ansible.

## How to Build

```sh
docker build -t 1000bulbs/docker-ubuntu-2204-ansible:latest .
```

## How to Pull

```sh
docker pull 1000bulbs/docker-ubuntu-2204-ansible:latest
```

## How to Use

Run a container:

```sh
docker run --name ansible --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --cgroupns=host 1000bulbs/docker-ubuntu-2204-ansible:latest
```

Run with local role:

```sh
docker run --name ansible --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --volume=`pwd`:/etc/ansible/roles/`basename $(pwd)`:ro --cgroupns=host 1000bulbs/docker-ubuntu-2204-ansible:latest
```

Check Ansible version:

```sh
docker exec --tty ansible env TERM=xterm ansible --version
```

Syntax check playbook:

```sh
docker exec --tty ansible env TERM=xterm ansible-playbook /path/to/playbook.yml --syntax-check
```
