puppet-sandbox
==============

## Description
This Vagrant-based Puppet development environment for creating new modules. 
Inspired by [elasticdog/puppet-sandbox](https://github.com/elasticdog/puppet-sandbox).

Puppet Sandbox will set up and configure five separate virtual machines:

* _puppet.example.com_ - the Puppet master server           
* _influxdbSeed.example.com_ - the influxdb seed node       
* _influxdbChild1.example.com_ - influxdb client nodes      
* _influxdbChild2.example.com_ - influxdb client nodes      
* _grafana.example.com_ - grafana + apache server           

These VMs can be used in conjunction to segregate and test your modules
based on node roles, Puppet environments, etc. 


## Requirements
To use Puppet Sandbox, you must have the following items installed and working:

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant 1.1+](http://vagrantup.com/)

Currently we are using *centos-64-x64-vbox4210* (centOS) box to do the demo.

## Instructions
Make sure you have a compatible Vagrant base box (if you don't have one
already, it will download a 64-bit centOS box for you), and then you
should be good to clone this repo and go:

    $ vagrant box list
    centos-64-x64-vbox4210
    $ git clone git@github.paypal.com:tzhang1/puppet-sandbox.git
    $ cd puppet-sandbox/

## Initial Startup
To bring up the Puppet Sandbox environment, issue the following command:

    $ vagrant up --provision

The following tasks will be handled automatically:

1. The Puppet server daemon will be installed and enabled on the master machine.
2. The Puppet client agent will be installed and enabled on all four machines.
3. A host-only network will be set up with all machines knowing how to communicate with each other.
4. All client certificate requests will be automatically signed by the master server. (now the setting is the master will auto-sign all certificate requests but it might need to change due to security concerns)
5. The master server will utilize the `nodes.pp` file and `modules/` directory that exist **outside of the VMs** (in your puppet-sandbox Git working directory) by utilizing VirtualBox's shared folder feature.


## Check Your Handiwork 
To log on to the virtual machines and see the result of your applied Puppet modules, just use standard [Vagrant Multi-VM Environment](http://vagrantup.com/docs/multivm.html) commands, and provide the
proper VM name (`puppet`, `influxdbSeed`, `influxdbChild1`, `influxdbChild2` and `grafana`):

    $ vagrant ssh influxdbSeed

If you don't want to wait for the standard 30-minutes between Puppet runs by the agent daemon, you can easily force a manual run:

    [vagrant@influxdbSeed ~]$ sudo puppet agent --test

**[Note]** 
*Unfortunately the vagrant process is not very stable, which means even the firewall has been shut down, puppet agents still have chance to unable to connect to the master --which really sucks.*
*My suggestion here is to do `sudo vagrant reload $node_name --provision` and often the problem is resolved.*

## See Visualized Result!
1. Database cluster - you should be able to see database cluster (under cluster tab) from any of the hosts of three nodes in port 8083. 
  e.g. http://172.16.32.11:8083/ (**Note**: you need set up seed server + 2 nodes, i.e. run `sudo puppet agent --test` on influxdbSeed, influxdbChild1 and influxdbChild2, to see the 3 nodes cluster. InfluxdbSeed needs to be run first because it's defined as seed server that other db nodes are joining to.)
  If the connection failed somehow, it will reconnect again with more machines on the cluster.

  This is just because influxdb doesn't remove records of dead machines in the cluster.
2. Grafana - currently grafana is connected with seed influxdb. So you can see the visualization from http://172.16.32.12/ (though there is nothing inside because there is no data in db.)

## Next Step 
1. Set up on c3 instances
2. Include Hiera to pull site-specific data out of manifests. 
