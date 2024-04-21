
resource "openstack_networking_secgroup_v2" "k8s_sec_group" {
  name        = "k8s_sec_group"
  description = "Security group for the k8s instances"
}

resource "openstack_networking_secgroup_rule_v2" "k8s_22" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.k8s_sec_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "k8s_local_network" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 35535
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.k8s_sec_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "k8s_80" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.k8s_sec_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "k8s_8000" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8000
  port_range_max    = 8000
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.k8s_sec_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "k8s_443" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.k8s_sec_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "k8s_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.k8s_sec_group.id}"
}

resource "openstack_networking_secgroup_v2" "bastion_sec_group" {
  name        = "bastion_sec_group"
  description = "Security group for the bastion instance"
}

resource "openstack_networking_secgroup_rule_v2" "bastion_22" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.bastion_sec_group.id}"
}
resource "openstack_networking_secgroup_rule_v2" "bastion_80" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.bastion_sec_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "bastion_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.bastion_sec_group.id}"
}
resource "openstack_compute_keypair_v2" "terraform" {
  name       = "terraform"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
