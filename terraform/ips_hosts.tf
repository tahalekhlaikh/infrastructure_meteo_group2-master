resource "local_file" "ips_hosts" {
 filename = "ips_cluster"
 content = <<EOF
 bastion_ip_public="${openstack_compute_floatingip_v2.bastion_ip.address}"
 bastion_ip_private="${openstack_compute_instance_v2.bastion.access_ip_v4}"
 master_ip_private="${openstack_compute_instance_v2.masters[0].access_ip_v4}"
 worker1_ip_private="${openstack_compute_instance_v2.workers[0].access_ip_v4}"
 worker2_ip_private="${openstack_compute_instance_v2.workers[1].access_ip_v4}"
 worker3_ip_private="${openstack_compute_instance_v2.workers[2].access_ip_v4}"
 EOF
}
