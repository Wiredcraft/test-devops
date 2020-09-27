variable "do_token" {}
variable "do_image" {
  default = "centos-7-x64"
}
variable "do_size" {
  default = "512mb"
}
variable "do_region" {
  default = "sfo3"
}
variable "ssh_fingerprint" {}
variable "ssh_public_key" {
  default = "id_rsa.pub"
}
variable "ssh_private_key" {
  default = "id_rsa"
}
variable "ssh_user" {
  default = "root"
}
variable "ansible_inventory" {
  default = "./ansible/inventory.cfg"
}
variable "ansible_inventory_template" {
  default = "./ansible/inventory-template.cfg"
}
variable "ansible_playbook" {
  default = "./ansible/playbook.yml"
}
