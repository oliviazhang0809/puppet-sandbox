# -*- mode: ruby -*-
# vi: set ft=ruby :

#require 'vagrant-openstack-plugin'

VAGRANTFILE_API_VERSION = "2"
virtual_box = 'centos-64-x64-vbox4210'
openstack_box = 'emi-centos-6.4-x86_64'
provider = ENV['PROVIDER']                          # could be either "v: virtualbox" or "o: openstack"

# Hard-coded Default settings:
environment = "dev"
master_name = "puppet"
master_ip = "172.16.32.10"
virtual_box_domain = 'example.com'
puppet_hostname = master_name + "." + virtual_box_domain
cluster_seed_servers = "influxdbSeed." + virtual_box_domain  # this is for virtualbox, you need to setup for c3 instance after vagrant up influxdbSeed node
db_name = "test1"

$script = <<SCRIPT

gem install -q -v=3.7.2 --no-rdoc --no-ri puppet
gem install -v=2.2.8 --no-rdoc --no-ri CFPropertyList
gem install -q -v=1.1.1 --no-rdoc --no-ri hiera-file
gem install -q -v=1.0.1 --no-rdoc --no-ri deep_merge

# only need to do that for virtual box
if [ $1 = "v" ]; then
  echo  "$3 $2.example.com $2" >> /etc/hosts
fi
puppet agent --enable

SCRIPT

puppet_nodes = [
  {:hostname => master_name,    :role => 'master',        :ip => master_ip, :fwdhost => 8142, :fwdguest => 8140, :autostart => true, :ram => 1024},
  {:hostname => 'influxdbSeed',   :role => 'influxdbSeed',  :ip => '172.16.32.11', :fwdhost => 8004, :fwdguest => 8083, :autostart => true, :ram => 1024},
  {:hostname => 'grafana',        :role => 'grafana',       :ip => '172.16.32.12', :fwdhost => 8003, :fwdguest => 80,   :autostart => true, :ram => 1024},
  {:hostname => 'influxdbChild1', :role => 'influxdbChild', :ip => '172.16.32.13', :fwdhost => 8005, :fwdguest => 8083, :autostart => true, :ram => 1024},
  {:hostname => 'influxdbChild2', :role => 'influxdbChild', :ip => '172.16.32.14', :fwdhost => 8006, :fwdguest => 8083, :autostart => true, :ram => 1024},
  {:hostname => 'hekad',          :role => 'heka',          :ip => '172.16.32.15', :fwdhost => 8007, :fwdguest => 8125, :autostart => true, :ram => 1024},
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  puppet_nodes.each do |node|

    config.vm.provider :virtualbox do |vb, newconfig|
      newconfig.vm.box = virtual_box
      newconfig.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/" + virtual_box + ".box"
      vb.gui = false
      vb.memory = node[:ram]
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "75"]
    end

    config.vm.provider :openstack do |os, newconfig|
        newconfig.vm.box = openstack_box
        newconfig.vm.box_url = "http://stingray-vagrant.stratus.dev.ebay.com/vagrant/boxes/openstack/" + openstack_box + ".box"
        newconfig.ssh.private_key_path = "~/.ssh/metrics.pem"
        os.keypair_name = "metrics"
    end

    config.vm.define node[:hostname], autostart: node[:autostart] do |node_config|
      # only for virtualbox, hostname and ip need to be setup
      if provider == "v"
        node_config.vm.hostname = node[:hostname] + '.' + virtual_box_domain
        node_config.vm.network :private_network, ip: node[:ip]
      end

      if node[:fwdhost]
        node_config.vm.network :forwarded_port, guest: node[:fwdguest], host: node[:fwdhost]
      end

      node_config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      # setup role as a custom fact
      node_config.vm.provision "shell" do |s|
        s.inline = "mkdir -p /etc/facter/facts.d && echo role=$1 > /etc/facter/facts.d/role.txt"
        s.args = [ node[:role] ]
      end

      node_config.vm.provision "shell" do |s|
        s.inline = "mkdir -p /etc/facter/facts.d && echo environment=$1 > /etc/facter/facts.d/environment.txt"
        s.args = [ environment ]
      end

      node_config.vm.provision "shell" do |s|
        s.inline = "mkdir -p /etc/facter/facts.d && echo cluster_seed_servers=$1 > /etc/facter/facts.d/cluster_seed_servers.txt"
        s.args = [ cluster_seed_servers ]
      end

      node_config.vm.provision "shell" do |s|
        s.inline = "mkdir -p /etc/facter/facts.d && echo puppet_hostname=$1 > /etc/facter/facts.d/puppet_hostname.txt"
        s.args = [ puppet_hostname ]
      end

      node_config.vm.provision "shell" do |s|
        s.inline = "mkdir -p /etc/facter/facts.d && echo db_name=$1 > /etc/facter/facts.d/db_name.txt"
        s.args = [ db_name ]
      end

      node_config.vm.provision "shell", inline: $script, args: [ provider, master_name, master_ip ]

      if node[:role] == "master"
        node_config.vm.synced_folder ".", "/etc/puppet/", mount_options: ["dmode=777,fmode=666"]
        node_config.vm.provision :puppet do |puppet|
          puppet.hiera_config_path = "hiera.yaml"
          puppet.manifests_path = 'manifests'
          puppet.manifest_file  = "site.pp"
          puppet.module_path = ['modules', 'sites']
          puppet.facter = {
            "role" => node[:role],
            "environment" => environment,
            "cluster_seed_servers" => cluster_seed_servers,
            "puppet_hostname" => puppet_hostname,
            "db_name" => db_name
          }
          puppet.options = "--verbose --debug --test"
        end
      else
        node_config.vm.provision "puppet_server" do |puppet|
          puppet.puppet_server = puppet_hostname
          puppet.options = "--verbose --debug --test --waitforcert 60"
        end
      end
        # shut off the firewall
      node_config.vm.provision "shell", inline: "iptables -F"
      node_config.vm.provision "shell", inline: "service iptables save"
    end
  end
end
