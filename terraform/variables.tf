variable "gcp_project" {
  description = "Projeto para provisionamento da infra"
  type        = string
  default     = "devops-439704" #Project ID
}

variable "default_region" {
  description = "Região padrão de provisionamento"
  type        = string
  default     = "us-central1" #Region
}

variable "default_zone" {
  description = "Região padrão de provisionamento"
  type        = string
  default     = "us-central1-c"
}


variable "machine_type" {
  default     = "e2-medium"
  type        = string
  description = "Tamanho dos nodes do cluster gke"
}