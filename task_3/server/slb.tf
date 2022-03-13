module "xm_apisix_slb" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-slb.git?ref=v1.9.0"

  create            = true
  name              = "${local.bu}-nexus-${local.env}-10001-slb"
  spec              = "slb.s2.medium"
  address_type      = "internet"
  resource_group_id = local.res_grp_id
  vswitch_id        = local.srv_vsw_a_id
  servers_of_default_server_group = [
    {
      server_ids = join(",", module.xm_apisix_ecs.this_instance_id)
      weight     = "100"
      type       = "ecs"
    },
  ]
  tags = {
    appname = "${local.bu}-nexus"
    bu      = local.bu
    env     = local.env
  }

}

module "xm_apisix_slb_listener" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-slb-listener.git?ref=v1.4.0"

  create = true
  slb    = module.xm_apisix_slb.this_slb_id
  listeners = [
    {
      server_group_ids  = module.xm_apisix_slb.this_slb_virtual_server_group_id
      backend_port      = "80"
      frontend_port     = "80"
      protocol          = "tcp"
      bandwidth         = "-1"
      scheduler         = "wrr"
      gzip              = "false"
      health_check_type = "tcp"
    },
    {
      server_group_ids  = module.xm_apisix_slb.this_slb_virtual_server_group_id
      backend_port      = "443"
      frontend_port     = "443"
      protocol          = "tcp"
      bandwidth         = "-1"
      scheduler         = "wrr"
      gzip              = "false"
      health_check_type = "tcp"
    }
  ]
  health_check = {
    healthy_threshold     = "3"
    unhealthy_threshold   = "3"
    health_check_timeout  = "5"
    health_check_interval = "2"
    health_check          = "on"
  }
}

module "xm_apisix_slb_pv" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-slb.git?ref=v1.9.0"

  create            = true
  name              = "${local.bu}-nexus-${local.env}-10002-slb"
  spec              = "slb.s2.medium"
  address_type      = "intranet"
  resource_group_id = local.res_grp_id
  vswitch_id        = local.srv_vsw_a_id
  servers_of_default_server_group = [
    {
      server_ids = join(",", module.xm_apisix_ecs.this_instance_id)
      weight     = "100"
      type       = "ecs"
    },
  ]
  tags = {
    appname = "${local.bu}-nexus"
    bu      = local.bu
    env     = local.env
  }

}

module "xm_apisix_slb_listener_pv" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-slb-listener.git?ref=v1.4.0"

  create = true
  slb    = module.xm_apisix_slb_pv.this_slb_id
  listeners = [
    {
      server_group_ids  = module.xm_apisix_slb_pv.this_slb_virtual_server_group_id
      backend_port      = "80"
      frontend_port     = "80"
      protocol          = "tcp"
      bandwidth         = "-1"
      scheduler         = "wrr"
      gzip              = "false"
      health_check_type = "tcp"
    },
    {
      server_group_ids  = module.xm_apisix_slb_pv.this_slb_virtual_server_group_id
      backend_port      = "443"
      frontend_port     = "443"
      protocol          = "tcp"
      bandwidth         = "-1"
      scheduler         = "wrr"
      gzip              = "false"
      health_check_type = "tcp"
    },
    {
      server_group_ids  = module.xm_apisix_slb_pv.this_slb_virtual_server_group_id
      backend_port      = "8880"
      frontend_port     = "8880"
      protocol          = "tcp"
      bandwidth         = "-1"
      scheduler         = "wrr"
      gzip              = "false"
      health_check_type = "tcp"
      # acl_status        = "on"
      # acl_id            = local.slb_acl_jenkins
      # acl_type          = "white"
    },
    {
      server_group_ids  = module.xm_apisix_slb_pv.this_slb_virtual_server_group_id
      backend_port      = "8602"
      frontend_port     = "8602"
      protocol          = "tcp"
      bandwidth         = "-1"
      scheduler         = "wrr"
      gzip              = "false"
      health_check_type = "tcp"
    }
  ]
  health_check = {
    healthy_threshold     = "3"
    unhealthy_threshold   = "3"
    health_check_timeout  = "5"
    health_check_interval = "2"
    health_check          = "on"
  }
}

module "xm_apisixadmin_slb" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-slb.git?ref=v1.9.0"

  create            = true
  name              = "${local.bu}-nexusadmin-${local.env}-10001-slb"
  spec              = "slb.s2.medium"
  address_type      = "intranet"
  resource_group_id = local.res_grp_id
  vswitch_id        = local.srv_vsw_a_id
  servers_of_default_server_group = [
    {
      server_ids = join(",", module.xm_apisixadmin_ecs.this_instance_id)
      weight     = "100"
      type       = "ecs"
    },
  ]
  tags = {
    appname = "${local.bu}-nexusadmin"
    bu      = local.bu
    env     = local.env
  }

}

module "xm_apisixadmin_slb_listener" {
  source = "git::https://code.idiaoyan.cn/ops/terraform-alicloud-slb-listener.git?ref=v1.4.0"

  create = true
  slb    = module.xm_apisixadmin_slb.this_slb_id
  listeners = [
    {
      server_group_ids    = module.xm_apisixadmin_slb.this_slb_virtual_server_group_id
      backend_port        = "8800"
      frontend_port       = "8800"
      protocol            = "tcp"
      bandwidth           = "-1"
      scheduler           = "wrr"
      gzip                = "false"
      health_check_type   = "tcp"
      persistence_timeout = 1000
    }
  ]
  health_check = {
    healthy_threshold     = "3"
    unhealthy_threshold   = "3"
    health_check_timeout  = "5"
    health_check_interval = "2"
    health_check          = "on"
  }
}
