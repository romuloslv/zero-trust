resource "local_file" "inventory" {
  for_each        = { for server in local.instances : server.display_name => server }
  content         = templatefile("${path.module}/../templates/inventory.tftpl",
  { instance_ips  = [ for i in oci_core_instance.instances : i.public_ip if each.value.tag_name == i.freeform_tags["service"] ] })
  filename        = "${path.module}/../../sysout/hosts/${each.value.tag_name}/inventory"
  file_permission = "0644"
}