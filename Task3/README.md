# Description
Create an Elastic Compute Service (ECS) instance by using Terraform on Alibaba Cloud.
# Environment
- Terraform v1.1.9
- alicloud provider plugin aliyun/alicloud 1.164.0


# Prerequisites

Install and configure Terraform : [AliCloud doc](https://www.alibabacloud.com/help/en/elastic-compute-service/latest/install-and-configure-terraform-on-your-computer)


# Get Started

> Before starting, you can modify the configuration of the generated infrastructure by modifying the parameters in the `variable.tf`

Initialize the directory
```bash
terraform init
```
Create infrastructure
```bash
terraform apply
```




For more information see：
[Aliyun terraform Doc](https://www.alibabacloud.com/help/en/terraform/latest/terraform-introduction) and 
[terraform](https://www.terraform.io/)