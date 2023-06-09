data "oci_core_images" "oracle_linux" {
  compartment_id           = oci_identity_compartment.sandbox.id
  operating_system         = "Oracle Linux"
  operating_system_version = "9"
  filter {
    regex  = true
    name   = "display_name"
    values = [
      "^([a-zA-z]+)-([a-zA-z]+)-([\\.0-9]+)-([\\.0-9-]+)$",
      "^([a-zA-z]+)-([a-zA-z]+)-([\\.0-9]+)-([a-zA-Z0-9]+)-([\\.0-9-]+)$",
    ]
  }
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = oci_identity_compartment.sandbox.id
  ad_number      = 1
}

data "oci_identity_fault_domains" "fd" {
  compartment_id      = oci_identity_compartment.sandbox.id
  availability_domain = data.oci_identity_availability_domain.ad.name
}

data "oci_objectstorage_namespace" "ns" {
  compartment_id = oci_identity_compartment.sandbox.id
}