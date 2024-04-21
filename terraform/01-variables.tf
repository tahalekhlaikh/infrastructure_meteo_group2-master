variable "external_network_name" {
  type    = string
  default = "external"
}

variable "k8s_router_name" {
  type    = string
  default= "k8s_router"
}

variable "k8s_network_name" {
  type = string
  default="k8s_network"
}

variable "k8s_subnet_name" {
  type = string
  default="k8s_subnet"
}

variable "basiton_name" {
  type = string
  default="k8s-bastion"
}

variable "instance_image" {
  type    = string
  default = "imta-docker"
}

variable "instance_flavor" {
  description = "defining instace flavor"
  default     = "s10.medium"
}

variable "pool" {
  default = "public_floating_net"
}





 
# Flavor for master nodes
variable "master_flavor_name" {
  default = "s10.medium"
}
# Flavor for worker nodes
variable "worker_flavor_name" {
  default = "s10.medium"
}
# Flavor for bastion nodes
variable "bastion_flavor_name" {
  default = "s10.medium"
}
# Image for master nodes: Ubuntu 18.04
variable "master_image_uuid" {
  default = "e62b4773-ca26-4dbb-abfc-cba82ee4077d"
}
# Image for worker nodes: Ubuntu 18.04
variable "worker_image_uuid" {
  default = "e62b4773-ca26-4dbb-abfc-cba82ee4077d"
}
# Image for bastion nodes: Ubuntu 18.04
variable "bastion_image_uuid" {
  default = "e62b4773-ca26-4dbb-abfc-cba82ee4077d"
}

variable "ssh_user_name" {
  default = "ubuntu"
}

variable "number_of_master_nodes" {
  type    = number
  default = 1
}

variable "number_of_worker_nodes" {
  type    = number
  default = 3
}

# terraform {
#   backend "swift" {
#     container         = "terraform-state"
#     archive_container = "terraform-state-archive"
#   }
# }
# # SkyAtlas RC file variables
# variable "os_username" {}
# variable "os_project_name" {}
# variable "os_password_input" {}
# variable "os_auth_url" {}
# variable "os_region_name" {}
# variable "ssh_key_file" {}
