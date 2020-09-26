resource "digitalocean_droplet" "website" {
  image              = var.do_image
  region             = var.do_region
  name               = "website"
  size               = "512mb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]

  provisioner "local-exec" {
    command = <<EOT
      sed "s/{ ssh_host }/${self.ipv4_address}/" ${var.ansible_inventory_template} > ${var.ansible_inventory}
      ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_private_key} -i ${var.ansible_inventory} ${var.ansible_playbook}
    EOT
  }
}
