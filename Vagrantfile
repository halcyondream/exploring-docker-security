Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/focal64"  
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
    end
  
    config.vm.network "nat"
    config.vm.network "private_network", type: "dhcp"
  
    config.vm.provision "shell", path: "provision.sh"
  end
  