module "xm_vpc_service" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-vpc.git?ref=v1.11.0"

  create             = true
  vpc_name           = "zy-${local.bu}-${local.env}-10001-vpc"
  vpc_cidr           = "10.0.0.0/8"
  resource_group_id  = local.res_grp_id
  availability_zones = ["cn-shanghai-b", "cn-shanghai-g", "cn-shanghai-l"]
  vswitch_cidrs      = local.service_vswitch_cidrs
  vswitch_name       = [for _ in range(local.service_vswitch_count) : "${local.bu}-service-${local.env}"]

  vpc_tags = {
    creater = "terraform"
  }

  vswitch_tags = {
    tier    = "service"
    creater = "terraform"
  }
}

module "xm_vpc_data" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-vpc.git?ref=v1.11.0"

  vpc_id = module.xm_vpc_service.vpc_id
  availability_zones = ["cn-shanghai-b", "cn-shanghai-g", "cn-shanghai-l"]
  vswitch_cidrs      = local.data_vswitch_cidrs
  vswitch_name       = [for _ in range(local.data_vswitch_count) : "${local.bu}-data-${local.env}"]

  vswitch_tags = {
    tier    = "data"
    creater = "terraform"
  }
}