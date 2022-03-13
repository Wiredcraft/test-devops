locals {
  bu               = "xm"
  env              = "prod"
  res_grp_id       = data.alicloud_resource_manager_resource_groups.xmd.groups.0.id
  xm_base_image    = data.alicloud_images.xm_centos.ids[0]
  available_zone_a = "cn-shanghai-l"
  available_zone_b = "cn-shanghai-b"
  srv_vsw_a_id     = data.alicloud_vswitches.srv_vsw_a.ids[0]
  srv_vsw_b_id     = data.alicloud_vswitches.srv_vsw_b.ids[0]
  ecs_type_2c8g    = "ecs.g7.large"
  ecs_type_4c16g   = "ecs.g7.xlarge"
  ecs_type_8c32g   = "ecs.g7.2xlarge"
  xm_vpc_sg        = data.alicloud_security_groups.xm_vpc_sg.ids
  xm_data_sg       = data.alicloud_security_groups.xm_data_sg.ids
  xm_service_sg    = data.alicloud_security_groups.xm_service_sg.ids
  xm_apisix_sg     = data.alicloud_security_groups.xm_apisix_sg.ids
  # xm_apisixadmin_sg = data.alicloud_security_groups.xm_apisixadmin_sg.ids
  slb_acl_jenkins = data.alicloud_slb_acls.jenkins.acls.0.id
}

data "alicloud_resource_manager_resource_groups" "xmd" {
  name_regex = "xmd"
  status     = "OK"
}

data "alicloud_images" "xm_centos" {
  most_recent = true
  name_regex  = "^ops-centos7"
}

data "alicloud_vswitches" "srv_vsw_a" {
  zone_id    = local.available_zone_a
  name_regex = "${local.bu}-service-${local.env}"
}

data "alicloud_vswitches" "srv_vsw_b" {
  zone_id    = local.available_zone_b
  name_regex = "${local.bu}-service-${local.env}"
}

data "alicloud_security_groups" "xm_vpc_sg" {
  name_regex = "zy-${local.bu}-${local.env}"
}

data "alicloud_security_groups" "xm_data_sg" {
  name_regex = "${local.bu}-data-${local.env}"
}

data "alicloud_security_groups" "xm_service_sg" {
  name_regex = "${local.bu}-service-${local.env}"
}

data "alicloud_security_groups" "xm_apisix_sg" {
  name_regex = "${local.bu}-apisix-${local.env}"
}

# data "alicloud_security_groups" "xm_apisixadmin_sg" {
#   name_regex = "${local.bu}-xm_apisixadmin_sg-${local.env}"
# }

data "alicloud_instance_types" "xm_2c8g_ecs_type" {
  for_each          = toset([local.available_zone_a, local.available_zone_b])
  cpu_core_count    = 2
  memory_size       = 8
  availability_zone = each.key
}

data "alicloud_instance_types" "xm_4c16g_ecs_type" {
  for_each          = toset([local.available_zone_a, local.available_zone_b])
  cpu_core_count    = 4
  memory_size       = 16
  availability_zone = each.key
}

data "alicloud_instance_types" "xm_8c32g_ecs_type" {
  for_each          = toset([local.available_zone_a, local.available_zone_b])
  cpu_core_count    = 8
  memory_size       = 32
  availability_zone = each.key
}

data "alicloud_slb_acls" "jenkins" {
  name_regex = "jenkins"
}
