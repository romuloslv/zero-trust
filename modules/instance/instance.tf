locals {
  instances = flatten([
    for srv in var.configuration : [
      for i in range(srv.no_of_instances) : {
        display_name    = "${srv.application_name}-s${i + 1}"
        shape           = srv.shape
        memory_quantity = srv.memory_quantity
        cpu_quantity    = srv.cpu_quantity
        bot_volume_size = srv.bot_volume_size
        os_system       = srv.os_system
        no_of_instances = srv.no_of_instances
      }
    ]
  ])
}

resource "oci_core_instance" "instances" {
  for_each             = { for server in local.instances : server.display_name => server }
  display_name         = each.value.display_name
  availability_domain  = data.oci_identity_availability_domain.ad.name
  fault_domain         = data.oci_identity_fault_domains.fd.fault_domains[each.value.no_of_instances].name
  compartment_id       = var.compartment_ocid
  shape                = each.value.shape
  state                = var.instance_state
  preserve_boot_volume = false

  create_vnic_details {
    assign_private_dns_record = true
    assign_public_ip          = true
    subnet_id                 = var.subnet_ocid
    hostname_label            = each.value.display_name
    private_ip                = cidrhost(var.subnet_cidr_block, index(local.instances, each.value) + 10)
    nsg_ids                   = [oci_core_network_security_group.nsg.id]
  }

  source_details {
    source_id               = contains(tolist(split("-", each.value.display_name)), "master") ? data.oci_core_images.oracle_linux.images[1].id : data.oci_core_images.oracle_linux.images[0].id
    boot_volume_size_in_gbs = each.value.bot_volume_size
    source_type             = "image"
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.key.public_key_openssh
    user_data           = filebase64("${path.module}/../scripts/run.sh")
  }

  shape_config {
    memory_in_gbs = each.value.memory_quantity
    ocpus         = each.value.cpu_quantity
  }
}