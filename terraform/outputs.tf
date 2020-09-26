output "ip" {
  value = "${digitalocean_droplet.website.ipv4_address}"
}
