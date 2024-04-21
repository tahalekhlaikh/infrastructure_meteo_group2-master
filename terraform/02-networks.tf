data "openstack_networking_network_v2" "external_network" {
  name         = var.external_network_name
}

resource "openstack_networking_network_v2" "k8s_network" {
  name           =var.k8s_network_name
}

resource "openstack_networking_router_v2" "k8s_router" {
  name                = var.k8s_router_name
  external_network_id = "${data.openstack_networking_network_v2.external_network.id}"
}

resource "openstack_networking_subnet_v2" "k8s_subnet" {
  name            = var.k8s_subnet_name
  network_id      = "${openstack_networking_network_v2.k8s_network.id}"
  cidr            = "192.168.1.0/24"
  ip_version      = 4
  dns_nameservers =  ["192.44.75.10","192.108.115.2"]
}

resource "openstack_networking_router_interface_v2" "k8s_network" {
  router_id = "${openstack_networking_router_v2.k8s_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.k8s_subnet.id}"
}

resource "openstack_compute_floatingip_v2" "bastion_ip" {
    pool = data.openstack_networking_network_v2.external_network.name
}

resource "openstack_compute_floatingip_v2" "master_ip" {
    pool = data.openstack_networking_network_v2.external_network.name
}


