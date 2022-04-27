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
