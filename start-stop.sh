#!/bin/bash

# Configurações
VMS=("cicd" "cicd-tools" "k3s" "gitlab-ci")
ZONE="us-central1-c"  # Substituir pela zona correta

# Função para ligar VMs
start_vms() {
  echo "Ligando VMs..."
  for vm in "${VMS[@]}"; do
    gcloud compute instances start "$vm" --zone="$ZONE"
    echo "VM $vm ligada."
  done
}

# Função para desligar VMs
stop_vms() {
  echo "Desligando VMs..."
  for vm in "${VMS[@]}"; do
    gcloud compute instances stop "$vm" --zone="$ZONE"
    echo "VM $vm desligada."
  done
}

# Verifica a ação passada como argumento
if [ "$1" == "start" ]; then
  start_vms
elif [ "$1" == "stop" ]; then
  stop_vms
else
  echo "Uso: $0 {start|stop}"
fi
