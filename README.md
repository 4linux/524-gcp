Laboratório GCP - 524 - CI/CD: Integração e entrega continua com Jenkins, Nexus, Sonarqube, Gitlab-ci e Github actions - LC
=============================

### Deploy no Kubernetes

Repositório para armazenar o Laboratório do curso de Integração e Entrega Continua com Git, Jenkins, Nexus e SonarQuebe da [4Linux][1]


Dependências
------------

Para a criação do laboratório é necessário ter pré instalado os seguintes softwares:

* [Git][2]
* [Terraform][3]
* [Ansible][5]
* [gcloudCLI][7]

> Para o máquinas com Windows aconselhamos, se possível, que as instalações sejam feitas pelo gerenciador de pacotes **[Cygwin][6]**.

> Para as máquinas com MAC OS aconselhamos, se possível, que as instalações sejam feitas pelo gerenciador de pacotes **brew**.

## Laboratório
-----------

O Laboratório será criado utilizando o [Terraform]

Nesse laboratórios, que está centralizado no arquivo Terraform, serão criadas 4 maquinas com as seguintes características:

Nome       | 
---------- |
cicd       |
cicd-tools |
k3s    |
gitlab-ci |


## Criação do Laboratório 


Faça o processo de Clonagem: 

```bash
git clone -b k3s https://github.com/4linux/524-gcp
cd 524-gcp/
```

Em `terraform/variables.tf` edite a linha 4 com o ID do seu Projeto que criamos na GCP. 

Após isso, certifique-se de logar na GCP usando o `gcloud CLI`

```bash
gcloud auth login 

```
Após o login em sua conta Gmail pelo navegador faça aa execução do script  `initial.sh`, conforme abaixo:


```bash
chmod +x initial.sh

./initial.sh

```
Vai ser executado de forma automática, o Terraform criando as 4 VM e realizando as configurações básicas das VM usando o Ansible.


_O Laboratório **pode demorar**, dependendo da conexão de internet e poder computacional, para ficar totalmente preparado._



[1]: https://4linux.com.br
[2]: https://git-scm.com/downloads
[3]: https://developer.hashicorp.com/terraform/install#linux
[5]: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
[6]: https://cygwin.com/install.html
[7]: https://cloud.google.com/sdk/docs/install?hl=pt-br
[8]: ./Vagrantfile
[13]: https://www.vagrantup.com/docs
[14]: https://app.vagrantup.com/4linux


## Desligar e Ligar Ambiente

### Desligar VM's

Execute o script start-stop que está no repositório:

```bash

./start-stop stop

```

### Ligar as  VM's

Execute o script start-stop que está no repositório:

```bash

./start-stop stop

terraform -chdir="terraform" apply -auto-approve #Talvez os ip publicos troquem, então execute novamente o terraform apply

```