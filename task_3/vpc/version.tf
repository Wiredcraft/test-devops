terraform {
  required_version = "~> 1.0.4"
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 1.132.0"
    }
  }
}