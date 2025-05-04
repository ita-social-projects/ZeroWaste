# Project Setup Guide

# Prerequisites

Install Ansible (Ubuntu)
Run the following commands to install Ansible on Ubuntu:

```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
```

# Secrets Configuration

1. Navigate to the secrets folder:
   `cd ansible1/roles/postgresql/vars`
2. Create an encrypted secrets file:
   `ansible-vault create secrets.yml`
   Add the following content:
   `postgres_user_password: "postgress_password"`
   💡 Replace "your_postgres_password" with your actual password.
3. To use this this file:
   `ansible-vault decrypt secrets.yml`
   You'll be prompted to create and confirm a vault password when creating or decrypting the file.

# Environment Configuration

In the root of the project, create a .env file with the following content:
`DATABASE_URL="postgres://postgres:postgress_password@localhost:5432/zero_waste_development"`
💡 Ensure the password here matches the one in secrets.yml.

# Running the Ansible Playbook

To set up your development environment, run:

`ansible-playbook -i inventory/local playbook-develop.yml --ask-become-pass`
This will prompt for your sudo password and begin provisioning your environment.

After successful installing project setup do next:

```
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
rails assets:precompile
rails db:migrate
```

To run application, use next command:

```
rails server
```
