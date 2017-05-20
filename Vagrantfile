# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
  end
  config.vm.define :master do |master_config|
    master_config.vm.box = "debian/contrib-jessie64"
    master_config.vm.host_name = 'schemaverse.local'
    master_config.vm.network "private_network", ip: "192.168.50.10"
    master_config.vm.synced_folder "saltstack/salt/", "/srv/salt"
    master_config.vm.synced_folder "saltstack/pillar/", "/srv/pillar"

    master_config.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = "saltstack/etc/minion"
      salt.run_highstate = true
      salt.install_type = "stable"
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end
end
