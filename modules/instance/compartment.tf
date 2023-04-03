resource "oci_identity_compartment" "sandbox" {
    compartment_id = var.tenancy
    description    = "zero trust poc"
    name           = "sandbox"
    enable_delete  = true
}