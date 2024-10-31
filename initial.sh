#!/bin/sh

# Parar na primeira falha
set -e

# Variáveis
TERRAFORM_DIR="terraform"
ANSIBLE_PLAYBOOK="ansible/cicd-playbook.yml"
INVENTORY_FILE="$TERRAFORM_DIR/inventory"

# Função de log para saída formatada
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

### Inicializando infra via Terraform
log "Inicializando infra via Terraform... Aguarde."

terraform -chdir="$TERRAFORM_DIR" init
log "Terraform init concluído."

terraform -chdir="$TERRAFORM_DIR" plan
log "Terraform plan concluído."

terraform -chdir="$TERRAFORM_DIR" apply -auto-approve
log "Terraform apply concluído."

### Gerando inventário dinâmico
log "Gerando inventário dinâmico.. Aguarde."

cd terraform && ./inventory.sh && cd ..
log "Criação de inventário concluído."


### Validando comunicação com as VM do curso na GCP
log "Validando comunicação com as VM do curso na GCP... Aguarde."

ansible -i "$INVENTORY_FILE" all -m ping \
  --ssh-extra-args='-o StrictHostKeyChecking=no'
log "Configuração com Ansible concluída."



### Inicializando infra com Ansible
log "Inicializando configurações com Ansible... Aguarde."

ansible-playbook "$ANSIBLE_PLAYBOOK" -i "$INVENTORY_FILE" \
  --ssh-extra-args='-o StrictHostKeyChecking=no'
log "Configuração com Ansible concluída."
