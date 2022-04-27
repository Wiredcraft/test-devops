variable "number" {
default = "1"
}

variable "count_format" {
default = "%02d"
}

variable "image_id" {
default = "centos_7_9_x64_20G_alibase_20220322.vhd"
}

variable "role" {
default = "wiredcraft-test"
}

variable "datacenter" {
default = "hangzhou"
}

variable "short_name" {
default = "wiredcraft"
}

variable "ecs_type" {
default = "ecs.n4.small"
}

variable "internet_max_bandwidth_out" {
default = 5
}

variable "disk_category" {
default = "cloud_efficiency"
}

variable "disk_size" {
default = "40"
}

variable "nic_type" {
default = "intranet"
}

variable "key_name" {
default     = "local-pc"
}


