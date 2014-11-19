# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_VERSION = "2"
domain = 'example.com'
box = 'centos-64-x64-vbox4210'

# hiera associated
environment = "dev"

puppet_nodes = [
  {:hostname => 'puppet', :role => 'master', :ip => '172.16.32.10', :box => box, :fwdhost => 8142, :fwdguest => 8140, :ram => 512},
  {:hostname => 'influxdbSeed', :role => 'influxdb', :ip => '172.16.32.11', :box => box, :fwdhost => 8004, :fwdguest => 8083},
  {:hostname => 'grafana', :role => 'grafana', :ip => '172.16.32.12', :box => box, :fwdhost => 8003, :fwdguest => 80},
  {:hostname => 'influxdbChild1', :role => 'influxdb', :ip => '172.16.32.13', :box => box, :fwdhost => 8005, :fwdguest => 8083},
  {:hostname => 'influxdbChild2', :role => 'influxdb', :ip => '172.16.32.14', :box => box, :fwdhost => 8006, :fwdguest => 8083},
]

Vagrant.configure(VAGRANT_VERSION) do |config|
  puppet_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.hostname = node[:hostname] + '.' + domain
      node_config.vm.network :private_network, ip: node[:ip]
      if node[:fwdhost]
        node_config.vm.network :forwarded_port, guest: node[:fwdguest], host: node[:fwdhost]
      end
      node_config.vm.provider :virtualbox do |vb, newconfig|
        newconfig.vm.box = node[:box]
        newconfig.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/" + box + ".box"
        vb.gui = false
        vb.memory = 1024
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
      end

      # install puppet gem
      node_config.vm.provision "shell", inline: "gem install -q -v=3.7.2 --no-rdoc --no-ri puppet"

      node_config.vm.provision :puppet do |puppet|
        puppet.hiera_config_path = "provision/manifests/hiera.yaml"
        puppet.manifests_path = 'provision/manifests'
        puppet.manifest_file  = "default.pp"
        puppet.module_path = 'provision/modules'
        puppet.facter = {
          "environment" => environment
        }
      end

      # shut off the firewall
      node_config.vm.provision "shell", inline: "iptables -F"
      node_config.vm.provision "shell", inline: "service iptables save"
    end
  end
end
