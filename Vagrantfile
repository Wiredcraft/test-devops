# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
    config.ssh.insert_key = false
    config.vm.box = "ubuntu/trusty64"
    config.vm.provider "virtualbox" do |v|
        v.linked_clone = true
        v.memory = 512
        v.cpus = 2
    end

    config.vm.network :private_network, type: "dhcp"


    # Number of web server instance
    webServerCount=3
    webServers = (1..webServerCount).map {|x|"web-#{x}"}
    webServers.each do |name|
        config.vm.define name do |host|
            host.vm.hostname = name
        end
    end

    # Master server, running nginx and swarm manager
    config.vm.define "master", primary: true do |host|
        host.vm.hostname = "master"
        # Mapped http port on host
        host.vm.network "forwarded_port", guest: 80, host: 8080
        config.vm.provision "ansible" do |ansible|
            ansible.sudo = true
            ansible.limit = "all"
            ansible.verbose = "v"
            ansible.playbook="setup.yml"
            ansible.groups = {
                "web" => webServers,
                "master" => ["master"]
            }
        end
    end
end
