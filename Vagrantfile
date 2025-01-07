servers=[
  {
    :hostname => "manager",
    :ip => "192.168.100.10",
    :box => "ubuntu/jammy64",
    :ram => 2048,
    :cpu => 2
  },
  {
    :hostname => "worker-1",
    :ip => "192.168.100.11",
    :box => "ubuntu/jammy64",
    :ram => 2048,
    :cpu => 2
  },
  {
    :hostname => "worker-2",
    :ip => "192.168.100.12",
    :box => "ubuntu/jammy64",
    :ram => 2048,
    :cpu => 2
  }
]
Vagrant.configure(2) do |config|
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
      node.vm.synced_folder "shared/", "/home/vagrant/shared"
      node.vm.network "private_network", ip: machine[:ip]
      node.vm.provider "virtualbox" do |vbox|
        # vbox.gui = true
        vbox.name = "docker-#{machine[:hostname]}"
        vbox.memory = machine[:ram]
        vbox.cpus = machine[:cpu]
        # vbox.allowlist_verified = true
      end

     # Step 1: Install Docker first
     node.vm.provision "shell", :path => "script/docker_install.sh"

     # Step 2: Conditional provisioning for swarm
     if machine[:hostname] == "manager"
       # If hostname is 'manager', initialize Docker Swarm
       node.vm.provision "shell", inline: <<-SHELL
         echo "Running swarm init for manager..."
         chmod +x shared/script/init_swarm.sh
         bash shared/script/init_swarm.sh
       SHELL
     elsif machine[:hostname].start_with?("worker")
       # If hostname is 'worker', join Docker Swarm
       node.vm.provision "shell", inline: <<-SHELL
         echo "Running swarm join for worker..."
         chmod +x shared/script/join_swarm.sh
         bash shared/script/join_swarm.sh
       SHELL
      end
    end
  end
end

