terraform {
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
  required_version = ">= 1.0.0"
}