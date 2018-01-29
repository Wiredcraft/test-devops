# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos7"
  #config.vm.hostname = "vagrant"
  config.ssh.insert_key = false

  # config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 80, host: 8080

  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
  config.vm.boot_timeout = 20

  # config.vm.synced_folder "/Users/irina/wired", "/vagrant"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider "virtualbox" do |vb|
     #v.name = "jenkins"
     vb.memory = "1024"
   end

  config.vm.provision "shell", inline: <<-SHELL
  # install hugo
  # wget http://archive.ubuntu.com/ubuntu/pool/universe/h/hugo/hugo_0.26-1_amd64.deb
  # sudo dpkg -i hugo*.deb
     # apt-get update
     # apt-get install -y apache2
  SHELL
  config.vm.provision "ansible" do |ansible|
        ansible.inventory_path = "ansible/inventory"
        ansible.verbose = "v"
        ansible.playbook = "playbook.yml"
        ansible.sudo = true
  end
end
