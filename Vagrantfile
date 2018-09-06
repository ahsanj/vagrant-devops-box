# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
	config.vm.define "ultimate-box" do |devops|
		devops.vm.box = "ubuntu/xenial64"
      		devops.vm.provision "shell", path: "install.sh"
    		devops.vm.provider "virtualbox" do |v|
    		  v.memory = 4096
    		  v.cpus = 2
    		end
	end
end
