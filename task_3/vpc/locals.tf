data "alicloud_resource_manager_resource_groups" "xmd" {
  name_regex = "xmd"
  status     = "OK"
}

locals {
  bu                    = "xm"
  env                   = "prod"
  res_grp_id            = data.alicloud_resource_manager_resource_groups.xmd.groups.0.id
  service_vswitch_cidr  = "10.10.64.0/20"
  service_vswitch_cidrs = cidrsubnets(local.service_vswitch_cidr, 4, 4, 4)
  service_vswitch_count = length(local.service_vswitch_cidrs)
  data_vswitch_cidr     = "10.10.80.0/20"
  data_vswitch_cidrs    = cidrsubnets(local.data_vswitch_cidr, 4, 4, 4)
  data_vswitch_count    = length(local.data_vswitch_cidrs)
}