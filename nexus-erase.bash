#!/bin/bash

# Configurações do Nexus
NEXUS_URL="http://34.133.13.241:8081"
REPO_NAME="github-actions"
USERNAME="admin"
PASSWORD="4linux"

# Função para remover as imagens
remove_images() {
  # Obter todos os componentes (imagens) no repositório especificado
  components=$(curl -s -u "$USERNAME:$PASSWORD" "$NEXUS_URL/service/rest/v1/components?repository=$REPO_NAME")

  # Verificar se a resposta não é JSON válido
  echo "$components" | jq . >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "A resposta da API não é um JSON válido. A resposta recebida foi:"
    echo "$components"
    exit 1
  fi

  # Verificar se o campo 'items' contém elementos
  if [ -z "$(echo "$components" | jq -r '.items[]')" ]; then
    echo "Nenhuma imagem encontrada no repositório $REPO_NAME."
    exit 0
  fi

  # Loop para excluir cada componente
  for component_id in $(echo "$components" | jq -r '.items[].id'); do
    echo "Removendo imagem com ID: $component_id"
    curl -s -u "$USERNAME:$PASSWORD" -X DELETE "$NEXUS_URL/service/rest/v1/components/$component_id"
    if [ $? -eq 0 ]; then
      echo "Imagem $component_id removida com sucesso."
    else
      echo "Falha ao remover a imagem $component_id."
    fi
  done
}

# Chamada para remover as imagens
remove_images
