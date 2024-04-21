resource "openstack_compute_instance_v2" "bastion" {
  name            = "bastion"
  image_name      = var.instance_image
  flavor_name     = var.instance_flavor
  key_pair        = "${openstack_compute_keypair_v2.terraform.id}"
  security_groups = ["${openstack_networking_secgroup_v2.bastion_sec_group.name}"]

  network {
    uuid = "${openstack_networking_network_v2.k8s_network.id}"
  }
  
}

resource "openstack_compute_floatingip_associate_v2" "floatip_bastion" {
  floating_ip = "${openstack_compute_floatingip_v2.bastion_ip.address}"
  instance_id = "${openstack_compute_instance_v2.bastion.id}" 
}

resource "openstack_compute_floatingip_associate_v2" "floatip_master" {
  floating_ip = "${openstack_compute_floatingip_v2.master_ip.address}"
  instance_id = "${openstack_compute_instance_v2.masters[0].id}" 
}

resource "openstack_compute_instance_v2" "masters" {
  count           = var.number_of_master_nodes
  image_name=     "imta-docker"
  name            = "k8s-master${count.index +1}"
  flavor_name     = var.instance_flavor
  key_pair        = "${openstack_compute_keypair_v2.terraform.id}"
  security_groups = ["${openstack_networking_secgroup_v2.k8s_sec_group.name}"]
  network {
    uuid = "${openstack_networking_network_v2.k8s_network.id}"
  }
}

resource "openstack_compute_instance_v2" "workers" {
  count           = var.number_of_worker_nodes
  name            = "k8s-worker${count.index +1}"
  image_name="imta-docker"
  flavor_name     = var.instance_flavor
  key_pair        = "${openstack_compute_keypair_v2.terraform.id}"
  security_groups = ["${openstack_networking_secgroup_v2.k8s_sec_group.name}"]



  network {
    uuid = "${openstack_networking_network_v2.k8s_network.id}"
  }

}
