Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-16.04"

  # change ip if necessary
  config.vm.network "private_network", ip: "192.168.233.10"

  # ansible provision
  config.vm.provision "ansible" do |ansible|
    ansible.sudo = true
    ansible.playbook = "playbook.yml"
  end

end
