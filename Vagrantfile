Vagrant.configure("2") do |config|

    # Define a simple Ubuntu 20.04 box.
    config.vm.box = "ubuntu/focal64"  
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
    end
  
    # Share this folder with Vagrant. (I hope no secrets leak into
    # the environment!)
    config.vm.synced_folder ".", "/provision", type: "virtualbox"

    # Bridged connection to the host's LAN. May want to use a host-only
    # adapter with "private_network" if you're on an untrusted network.
    config.vm.network "public_network"

    # Launch the provisioner.
    config.vm.provision "shell", path: "provision.sh"

    # "The devs said this broke something, so I disabled it!"
    #config.vm.provision "shell", inline: <<-SHELL
    #  sudo umount /provision
    #SHELL

end
  