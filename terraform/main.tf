resource "digitalocean_droplet" "website" {
  image              = var.do_image
  region             = var.do_region
  name               = "website"
  size               = var.do_size
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
}

resource "null_resource" "website-init" {
  triggers = {
    droplet_id = "${digitalocean_droplet.website.id}"
  }

  provisioner "local-exec" {
    # run ansible playbook
    command = <<EOT
      sed "s/{ ssh_host }/${digitalocean_droplet.website.ipv4_address}/" ${var.ansible_inventory_template} > ${var.ansible_inventory}
      sleep 60 && ANSIBLE_CONFIG=./ansible/ansible.cfg ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_private_key} -i ${var.ansible_inventory} ${var.ansible_playbook}
    EOT
  }
}
