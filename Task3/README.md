# Description
Create an Elastic Compute Service (ECS) instance by using Terraform on Alibaba Cloud.
# Environment
- Terraform v1.1.9
- alicloud provider plugin aliyun/alicloud 1.164.0


# Prerequisites

Before you begin, ensure that you have completed the following operations:
- Prepare an Alibaba Cloud account and an AccessKey pair (AccessKey ID and AccessKey secret) to use Terraform. You can go to the [Security Management](https://usercenter.console.aliyun.com/?spm=a2c63.p38356.0.0.402519dbawMNu3#/manage/ak) page of the Alibaba Cloud console to create or view your AccessKey pair.
- Install and configure Terraform.
- Create an environment variable to store authentication information
```bash
export ALICLOUD_ACCESS_KEY="LTAIUrZCw3********"
export ALICLOUD_SECRET_KEY="zfwwWAMWIAiooj14GQ2*************"
export ALICLOUD_REGION="cn-hangzhou"
```


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