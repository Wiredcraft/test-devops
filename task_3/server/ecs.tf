module "xm_apisix_ecs" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-ecs-instance.git?ref=xm"

  bu                   = local.bu
  env                  = local.env
  appname              = "${local.bu}-nexus"
  number_of_instances  = 2
  resource_group_id    = local.res_grp_id
  image_id             = local.xm_base_image
  instance_type        = local.ecs_type_2c8g
  instance_charge_type = "PrePaid"
  vswitch_ids          = [local.srv_vsw_a_id, local.srv_vsw_b_id]
  security_group_ids   = concat(local.xm_vpc_sg, local.xm_service_sg, local.xm_apisix_sg)

  system_disk_category = "cloud_essd"
  system_disk_size     = 80
  data_disks = [
    {
      name                 = "data_disk"
      data_disks           = 1
      delete_with_instance = true
      size                 = 100
      category             = "cloud_essd"
    }
  ]
  user_data = file("init_ecs_data.sh")

}

module "xm_apisixadmin_ecs" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-ecs-instance.git?ref=xm"

  bu                   = local.bu
  env                  = local.env
  appname              = "${local.bu}-nexusadmin"
  number_of_instances  = 2
  resource_group_id    = local.res_grp_id
  image_id             = local.xm_base_image
  instance_type        = local.ecs_type_2c8g
  instance_charge_type = "PrePaid"
  vswitch_ids          = [local.srv_vsw_a_id, local.srv_vsw_b_id]
  security_group_ids   = concat(local.xm_vpc_sg, local.xm_service_sg)

  system_disk_category = "cloud_essd"
  system_disk_size     = 80
  data_disks = [
    {
      name                 = "data_disk"
      data_disks           = 1
      delete_with_instance = true
      size                 = 40
      category             = "cloud_essd"
    }
  ]
  user_data = file("init_ecs_data.sh")

}

