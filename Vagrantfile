
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "private_network", ip: "192.168.50.4"
  config.vm.hostname = "devops-test"
  config.vm.box_check_update = false 
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = 2
    vb.name = "devopstest"
  end
 
  config.vm.provision "ansible" do |ansible|
    ansible.sudo = true
    ansible.playbook = "provision/playbook.yml"
  end
end
