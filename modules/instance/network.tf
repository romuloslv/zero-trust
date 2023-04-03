resource "oci_core_vcn" "vnc" {
	cidr_block     = "10.0.0.0/16"
	compartment_id = oci_identity_compartment.sandbox.id
	display_name   = "vcn-home"
	dns_label      = "vcnhome"
}

resource "oci_core_subnet" "pub_subnet" {
	cidr_block     = "10.0.0.0/24"
	compartment_id = oci_identity_compartment.sandbox.id
	display_name   = "subnet-home"
	dns_label      = "subnethome"
	route_table_id = oci_core_vcn.vnc.default_route_table_id
	vcn_id         = oci_core_vcn.vnc.id
}

resource "oci_core_internet_gateway" "ig" {
	compartment_id = oci_identity_compartment.sandbox.id
	display_name   = "Internet Gateway vcn-home"
	vcn_id         = oci_core_vcn.vnc.id
	enabled        = "true"
}

resource "oci_core_default_route_table" "generated_oci_core_default_route_table" {
	route_rules {
		destination       = "0.0.0.0/0"
		destination_type  = "CIDR_BLOCK"
		network_entity_id = oci_core_internet_gateway.ig.id
	}
	manage_default_resource_id = oci_core_vcn.vnc.default_route_table_id
}

resource "oci_core_network_security_group" "nsg" {
  compartment_id = oci_identity_compartment.sandbox.id
	vcn_id         = oci_core_vcn.vnc.id
  display_name   = "cluster"
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