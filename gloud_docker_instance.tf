provider "google" {
  credentials = file(var.creds_file)
  region      = var.regions_list[0]
  project     = var.project
}


resource "google_compute_instance" "worker_instance" {
  zone         = "${var.regions_list[0]}-a"
  count        = length(var.instances_names)
  name         = var.instances_names[count.index]
  machine_type = var.instance_flavors.worker


  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network = google_compute_network.default.name
    access_config {
    }
  }
  metadata = {

    ###################   OLD format:   ###################
    # ssh-keys = join("\n", [for a, b in var.ssh_keys_test : format("%s: %s", substr(a, 3, -1), b)])
    ###################   NEW format:   ###################
    ssh-keys = join("\n", [for a, b in var.ssh_keys : "${a}: ${b}"])
  }
}

#### Set up docker on instance

resource "null_resource" "setup_docker" {
  count = length(var.instances_names)

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.prvt_key)
      host        = google_compute_instance.worker_instance[count.index].network_interface.0.access_config.0.nat_ip
    }
    inline = [
      "apt-get update && apt-get install -y curl wget net-tools && apt-get install -y apt-transport-https ca-certificates  gnupg-agent software-properties-common && apt-get -y install python3 python3-pip",
      "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -",
      "add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable\"",
      "apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io",
      "curl -L \"https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
      "chmod +x /usr/local/bin/docker-compose",
      "ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose",
      "pip3 install docker-compose"
    ]
  }
}


output "ip" {
  value = google_compute_instance.worker_instance[*].network_interface.0.access_config.0.nat_ip
}
