# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/Trusty64"
  config.vm.provision "shell", path: "scripts/setup.sh"
  config.ssh.forward_agent = true
#  config.ssh.insert_key = false

  (1..3).each do |i|
    config.vm.define "broker#{i}" do |s|
      s.vm.hostname = "broker#{i}"
      s.vm.network "private_network", ip: "10.30.3.4#{i}", netmask: "255.255.255.0", virtualbox__intnet: "my-network", drop_nat_interface_default_route: true
      #s.vm.provision "shell", path: "scripts/start-all.sh", args:"#{i}", privileged: false
    end
  end

  (1..1).each do |i|
    config.vm.define "spark#{i}" do |s|
      s.vm.hostname = "spark#{i}"
      s.vm.network "private_network", ip: "10.30.3.3#{i}", netmask: "255.255.255.0", virtualbox__intnet: "my-network", drop_nat_interface_default_route: true
      s.vm.network :forwarded_port, guest: 4040, host: 4041
    end
  end

  config.vm.provider "virtualbox" do |v1|
     v1.memory = "1048"
     v1.cpus = 2
  end
end
