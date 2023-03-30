resource "oci_core_network_security_group" "nsg" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vnc_ocid
  display_name   = "group-cluster"
}

resource "oci_core_network_security_group_security_rule" "nsg_sr_1" {
  network_security_group_id = oci_core_network_security_group.nsg.id
  direction                 = "EGRESS"
  protocol                  = "ALL"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  stateless                 = false
}

resource "oci_core_network_security_group_security_rule" "nsg_sr_2" {
  network_security_group_id = oci_core_network_security_group.nsg.id
  direction                 = "INGRESS"
  protocol                  = "1"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  stateless                 = false
}

resource "oci_core_network_security_group_security_rule" "nsg_sr_3" {
  network_security_group_id = oci_core_network_security_group.nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  stateless                 = false
  tcp_options {
    destination_port_range {
      max = "22"
      min = "22"
    }
  }
}