terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket                      = "changeme"
    key                         = "changeme/terraform.tfstate"
    region                      = "changeme"
    shared_credentials_file     = "./modules/templates/credentials"
    endpoint                    = "https://changeme.compat.objectstorage.changeme.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.114.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

module "instance" {
  source        = "./modules/instance"
  configuration = var.configuration
}

provider "oci" {
  config_file_profile = "changeme"
}