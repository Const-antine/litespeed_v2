/********************
  Ansible Inventory
********************/

data "template_file" "ansible_inventory" {
  template = <<EOF
[all]
$${worker_node}

[worker]
$${worker_name}

[all:vars]
service_account_file=${var.creds_file}
EOF

  vars = {
    worker_node = join("\n", formatlist(
      "%s ansible_host=%s node_labels=\"{'azName':'%s','type':'%s'}\"",
      google_compute_instance.worker_instance.*.name,
      google_compute_instance.worker_instance.*.network_interface.0.access_config.0.nat_ip,
      google_compute_instance.worker_instance.*.zone,
      "worker",
      ),
    )
    worker_name = join("\n", formatlist("%s", google_compute_instance.worker_instance.*.name))

  }
}


resource "local_file" "ansible_inventory" {
  content  = data.template_file.ansible_inventory.rendered
  filename = local.work_space
}
