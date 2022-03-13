terraform {
  backend "oss" {
    bucket              = "ops-tf-prod-11561-oss"
    prefix              = "tf-alicloud-bestcem-xm/cn-shanghai/prod/service/gateway"
    key                 = "terraform.tfstate"
    acl                 = "private"
    region              = "cn-shanghai"
    encrypt             = "true"
    tablestore_endpoint = "https://ops-tf-prod-61.cn-shanghai.ots.aliyuncs.com"
    tablestore_table    = "ops_tf_prod_11561_tb"
  }
}