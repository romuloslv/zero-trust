resource "local_file" "inventory" {
  content = templatefile("${path.module}/../templates/inventory.tftpl",
  { instance_ips = [ for i in oci_core_instance.instances : i.public_ip ] })
  file_permission = "0644"
  filename        = "${path.module}/../../sysout/hosts/inventory"
}