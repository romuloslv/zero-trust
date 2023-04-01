terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket                      = "zero-trust"
    key                         = "tf/terraform.tfstate"
    region                      = "sa-saopaulo-1"
    endpoint                    = "https://gr571iukts9i.compat.objectstorage.sa-saopaulo-1.oraclecloud.com"
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

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.ssh_private_key
  region           = var.region
}

module "instance" {
  source           = "./modules/instance"
  compartment_ocid = var.compartment_ocid
  instance_state   = var.instance_state
  configuration    = var.configuration
  subnet_ocid      = var.subnet_ocid
  vnc_ocid         = var.vnc_ocid
}