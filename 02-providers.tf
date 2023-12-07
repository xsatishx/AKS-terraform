terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  client_id       = var.terraform_sp
  subscription_id = var.subscription_id
  client_secret =  "zdC8Q~rmPi64.jFR9htjsf32vxp9LR-B04acLa~3"
}

provider "helm" {
  kubernetes {
    host                   = module.az_aks.aks_config[0].host
    client_certificate     = base64decode(module.az_aks.aks_config[0].client_certificate)
    client_key             = base64decode(module.az_aks.aks_config[0].client_key)
    cluster_ca_certificate = base64decode(module.az_aks.aks_config[0].cluster_ca_certificate)
  }
}

#Backend

terraform {
  backend "azurerm" {
    storage_account_name = "akstfstate01" # UPDATE HERE.
    container_name       = "tfstate"           # UPDATE HERE.
    key                = "env-dev.tfstate"
    access_key         = "ORnI7ULFqFm8tSVxnpPx0Pjx/X33mbg2uyQPAReFXpM+tc+L+peCQ6ZVALgsra51u8UOD1N79Bff+AStL6D9fA=="
    }
}