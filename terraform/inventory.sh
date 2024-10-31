#!/bin/bash

# Executar o Terraform para obter os IPs
ips=$(terraform output -json instance_ips | jq -r '.[]')

# Colocar os IPs em um array
ip_array=($ips)

# Criar o arquivo inventory
cat <<EOL > inventory
[cicd]
${ip_array[0]} ansible_user=araujo_emerson28 ansible_ssh_private_key_file=terraform/id_rsa_gcp

[cicd-tools]
${ip_array[1]} ansible_user=araujo_emerson28 ansible_ssh_private_key_file=terraform/id_rsa_gcp

[k3s]
${ip_array[2]} ansible_user=araujo_emerson28 ansible_ssh_private_key_file=terraform/id_rsa_gcp

[gitlab-ci]
${ip_array[3]} ansible_user=araujo_emerson28 ansible_ssh_private_key_file=terraform/id_rsa_gcp
EOL