module "xm_ngw" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-nat-gateway.git?ref=v2.0.0"

  create     = true
  vpc_id     = module.xm_vpc_service.vpc_id
  vswitch_id = module.xm_vpc_service.this_vswitch_ids[0]
  ngw_name   = "zy-${local.bu}-${local.env}-10001-ngw"
  nat_type   = "Enhanced"

  // Create eip and bind them with nat gateway
  create_eip               = true
  number_of_eip            = 1
  eip_name                 = "${local.bu}-ngw-${local.env}"
  eip_bandwidth            = 200
  eip_isp                  = "BGP"
  eip_tags                 = {
    creater = "terraform"
    bu      = local.bu
    env     = local.env
    appname = "zy-${local.bu}"
  }
  nat_tags                 = {
      creater = "terraform"
  }
}

module "xm_snat" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-snat.git?ref=v1.2.0"

  create        = true
  snat_table_id = module.xm_ngw.this_snat_table_id

  # Default snat ip, which will be used for all snat entries.
  snat_ips = module.xm_ngw.this_eip_ips

  # Open for source cidrs
  snat_with_source_cidrs = [
    {
      name         = "${local.bu}-servicecidrs-${local.env}"
      source_cidrs = local.service_vswitch_cidr
    },
    {
      name         = "${local.bu}-datacidrs-${local.env}"
      source_cidrs = local.data_vswitch_cidr
    }
  ]

}


