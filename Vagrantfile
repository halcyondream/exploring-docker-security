Vagrant.configure("2") do |config|
    # Define the base box (Ubuntu 20.04)
    config.vm.box = "ubuntu/focal64"
  
    # Set the VM provider as VirtualBox
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
    end
  
    # NAT network (this is usually configured by default in Vagrant)
    config.vm.network "nat"
  
    # Host-only network with VirtualBox's default host-only interface
    config.vm.network "private_network", type: "dhcp"
  
    # Forward the SSH port on the host machine to port 2222 on the VM
    config.vm.network "forwarded_port", guest: 22, host: 2222
  
    # Run the external provisioning script
    config.vm.provision "shell", path: "provision.sh"
  end
  