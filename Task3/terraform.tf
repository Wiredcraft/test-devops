provider "alicloud" {}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "tf_test_foo"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = "172.16.0.0/21"
  zone_id = "cn-hangzhou-b"
}

resource "alicloud_security_group" "default" {
  name = "default"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_http_80" {
type              = "ingress"
ip_protocol       = "tcp"
nic_type          = var.nic_type
policy            = "accept"
port_range        = "80/80"
priority          = 1
security_group_id = alicloud_security_group.default.id
cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_https_443" {
type              = "ingress"
ip_protocol       = "tcp"
nic_type          = var.nic_type
policy            = "accept"
port_range        = "443/443"
priority          = 1
security_group_id = alicloud_security_group.default.id
cidr_ip           = "0.0.0.0/0"
}
resource "alicloud_security_group_rule" "allow_ssh_22" {
type              = "ingress"
ip_protocol       = "tcp"
nic_type          = var.nic_type
policy            = "accept"
port_range        = "22/22"
priority          = 1
security_group_id = alicloud_security_group.default.id
cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_disk" "disk" {
zone_id = alicloud_instance.instance[0].availability_zone
category          = var.disk_category
size              = var.disk_size
count             = var.number
}

resource "alicloud_instance" "instance" {
instance_name   = "${var.short_name}-${var.role}-${format(var.count_format, count.index + 1)}"
host_name       = "${var.short_name}-${var.role}-${format(var.count_format, count.index + 1)}"
image_id        = var.image_id
count           = var.number
key_name         = var.key_name
instance_type   = var.ecs_type
security_groups = alicloud_security_group.default.*.id
vswitch_id      = alicloud_vswitch.vsw.id

internet_max_bandwidth_out = var.internet_max_bandwidth_out

instance_charge_type          = "PostPaid"
system_disk_category          = "cloud_efficiency"
security_enhancement_strategy = "Deactive"
data_disks {
    name        = "disk1"
    size        = "100"
    category    = "cloud_efficiency"
    description = "disk1"
}
tags = {
    role = var.role
    dc   = var.datacenter
}
}