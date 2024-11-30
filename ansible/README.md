## Documentation: Using Ansible to Configure Monit on a Server

## Introduction

This documentation provides a guide on configuring Monit on a server using Ansible. Monit is a process supervision tool that monitors services and restarts them if they fail. Ansible automates the setup of Monit configurations, ensuring consistency across environments.

## Prerequisites

- Ansible installed on your local machine
- SSH access to the target server

## Ansible Playbook Breakdown

The playbook for Monit setup typically consists of the following tasks:

- Install Monit: Installs the Monit package on the server.
- Copy Monit Configuration Templates: Places your custom Monit configuration files in the appropriate directory.
- Start and Enable Monit: Ensures Monit is started and set to start on boot.

## Running the Ansible Playbook

Run the playbook from the Ansible directory with the following command for production environment:

```
ansible-playbook -i ./inventory-prod.yml ./monit-role.yml
```

or

```
ansible-playbook -i ./inventory-dev.yml ./monit-role.yml
```

for development environment

File secrets.yml is under gitignore but during execution ansible commands it should be present in vars folder

## Accessing to monit

Monit is accessible on the port `2812`