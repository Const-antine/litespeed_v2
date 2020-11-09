variable "project" {
  type    = string
  default = "modified-math-288510"
}

variable creds_file {
  type    = string
  default = "./account.json"
}

locals {
  work_space = "environments/${terraform.workspace}/hosts.ini"
}

variable prvt_key {
  type    = "string"
  default = "/Users/constantine/.ssh/gcloud_root"
}

variable ssh_keys {
  type = map
  default = {
    constantine = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNQD9ZR2/xbNoZdMkDDipzgxN3zk9649vuopR0NBJk7DsS2VAreicOOBMhyuFyFmxLlTWQUJkMgxJYiYB/HNb2KdSr7ACgS6LAcFB4PoJAIFHkqnU3wBU7zgJ+AErT1Y9qo50KfAPWST2hDprwQbealPfV0M87Bn/jWHJMtzaU6xA+kv0QiQw6lhTXuucP4+4k2yoZ0SIiCV4kPDr8oCbpKzjGx3jJ6fzBlEg/tssifaLhXDbVd4Kv+OHUi9eEV/iuiDGW2QodulhOkZcFD/la7joYB9Z86t7wq+G8Y37jkyvZWzv1IgCZs6CwtQzHl80HyJhT4J+vCloWjoEAkOVz constantine@Constantines-MacBook-Pro.local"
    root        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbnL3Ayw7Fh1cO14H0rUrtHRRuB/X5AUTLE5u1S15sKJbs6Q3VNsUevuNoMVs2/YdmVzWiP02GV0C9yRUZZynSSyldx4pBg+KHOXy7g+U2KMAXKW5bn3ZeTcb3F/M4OtY3XtQBl0YZ+EKqIpLCuBY+TugFL6VeVA2P6nBcyzpNDkd9QDHFPlHhpFzYGduT9d38kl8WiPcjPhLaRgkDnBP1v9g+ggO7ui+dFyaELOD0V7lciAM42LLR6vCqq/3Q09lQ5GzVA38bzRGQYuAqgNSUtvy3ryFAAkT+x+kTgMxquXce/N1iLTmB9QxVd1SuxGt+aQrlpe/kMK5mAgey2W/z root"
  }
}

variable "instance_flavors" {
  type        = map
  description = "Instance flavors for different roles"

  default = {
    worker = "e2-medium"
  }
}

variable "regions_list" {
  description = "List of Regions available in project"
  type        = list
  default     = ["europe-north1"]
}

variable "instances_names" {
  description = "Create VM instance with these names"
  type        = list(string)
  default     = ["vm_for_test", "lightweight-lts-instance"]
}

variable "image" {
  type    = string
  default = "debian-cloud/debian-10"
}

variable "open_ports" {
  type    = list
  default = ["80", "443", "7080", "8080", "22", "1000-2000"]
}

# variable "worker_count" {
#   type = number
# }
