# -*- mode: ruby -*-
# vi: set ft=ruby :

domain = 'example.com'
box = 'centos-64-x64-vbox4210'

puppet_nodes = [
  {:hostname => 'puppet', :role => 'master', :ip => '172.16.32.10', :box => box, :fwdhost => 8142, :fwdguest => 8140, :ram => 512},
  {:hostname => 'influxdbSeed', :role => 'influxdb', :ip => '172.16.32.11', :box => box, :fwdhost => 8004, :fwdguest => 8083},
  {:hostname => 'grafana', :role => 'grafana', :ip => '172.16.32.12', :box => box, :fwdhost => 8003, :fwdguest => 80},
  {:hostname => 'influxdbChild1', :role => 'influxdb', :ip => '172.16.32.13', :box => box, :fwdhost => 8005, :fwdguest => 8083},
  {:hostname => 'influxdbChild2', :role => 'influxdb', :ip => '172.16.32.14', :box => box, :fwdhost => 8006, :fwdguest => 8083},
]

Vagrant.configure("2") do |config|
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
      # install hiera file backend
      node_config.vm.provision "shell", inline: "gem install -q -v=1.1.0 --no-rdoc --no-ri hiera-file"
      # install hiera deep merge
      node_config.vm.provision "shell", inline: "gem install -q -v=1.0.1 --no-rdoc --no-ri deep_merge"

      node_config.vm.provision :shell do |shell|
        shell.inline = "mkdir -p /etc/puppet/modules;
                        gem install puppet-lint;
                        yum -y install telnet"
      end

      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'provision/manifests'
        puppet.module_path = 'provision/modules'
      end

      # shut off the firewall
      node_config.vm.provision "shell", inline: "iptables -F"
      node_config.vm.provision "shell", inline: "service iptables save"
    end
  end
end
