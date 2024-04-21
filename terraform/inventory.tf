resource "local_file" "inventory" {
 filename = "hosts.ini"
 content = <<EOF
 bastion ansible_host=${openstack_compute_floatingip_v2.bastion_ip.address} ansible_port=22 ansible_user=ubuntu ansible_ssh_private_key_file="~/.ssh/id_rsa"
 master ansible_host=${openstack_compute_instance_v2.masters[0].access_ip_v4} ansible_port=22 ansible_user=ubuntu ansible_ssh_private_key_file="~/.ssh/id_rsa" ansible_ssh_common_args='-o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p ubuntu@${openstack_compute_floatingip_v2.bastion_ip.address}"'
 #workers
 [workers]
 worker1 ansible_host=${openstack_compute_instance_v2.workers[0].access_ip_v4} ansible_port=22 ansible_user=ubuntu ansible_ssh_private_key_file="~/.ssh/id_rsa" ansible_ssh_common_args='-o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p ubuntu@${openstack_compute_floatingip_v2.bastion_ip.address}"'
 worker2 ansible_host=${openstack_compute_instance_v2.workers[1].access_ip_v4} ansible_port=22 ansible_user=ubuntu ansible_ssh_private_key_file="~/.ssh/id_rsa" ansible_ssh_common_args='-o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p ubuntu@${openstack_compute_floatingip_v2.bastion_ip.address}"'
 worker3 ansible_host=${openstack_compute_instance_v2.workers[2].access_ip_v4} ansible_port=22 ansible_user=ubuntu ansible_ssh_private_key_file="~/.ssh/id_rsa" ansible_ssh_common_args='-o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p ubuntu@${openstack_compute_floatingip_v2.bastion_ip.address}"'
 [workers]
 worker1
 worker2
 worker3
 EOF
}

