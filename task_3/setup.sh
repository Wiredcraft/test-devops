#!/bin/bash

git config --global credential.helper 'store --file ~/.git/.git-credentials'

cd vpc/
terraform init
terraform fmt -check -recursive
terraform plan -out=plan.tfplan
terraform apply -input=false plan.tfplan
cd server/
terraform init
terraform fmt -check -recursive
terraform plan -out=plan.tfplan
terraform apply -input=false plan.tfplan

