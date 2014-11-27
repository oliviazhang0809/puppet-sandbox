Metrics Setup Instructions
==============

## Description

Puppet Sandbox will set up and configure five separate machines:

* _puppet_ - the Puppet master server
* _influxdbSeed_ - the influxdb seed node       
* _influxdbChild1_ - influxdb client nodes      
* _influxdbChild2_ - influxdb client nodes      
* _grafana_ - grafana + apache server


## Initial Setup
1. Running with virtualbox, these machines will with the following ip addresses and ports:

* _puppet_ - 172.16.32.10:8140
* _influxdbSeed_ - 172.16.32.11:8083
* _grafana_ - 172.16.32.12:80
* _influxdbChild1_ - 172.16.32.13:8083
* _influxdbChild2_ - 172.16.32.14:8083

2. Default values in Vagrantfiles

`environment`: "dev" -- development environment

`provider`: "virtualbox"

`cluster_seed_servers`: "influxdbSeed.example.com"

3. Admin & Password for influxdb
`
 
## Play Around

[Step 1]
Before `vagrant up` your boxes, please finish [INSTALLATION](https://github.paypal.com/Stingray/dev-environment/blob/develop/INSTALLATION.md) so that you have the workable environment setup.

[Step 2]
Install [librarian-puppet](https://github.com/rodjek/librarian-puppet/blob/master/README.md#how-to-use) gem to import modules.

(Install librarian-puppet gem & puppet gem)

    $ sudo gem install librarian-puppet -v=1.3.2

    $ sudo gem install puppet -v=3.7.2

And then under the project root path, run

    $ librarian-puppet install
    
so you will have an extra folder `modules` which contains all dependencies.

_TODO_ We will probably automate this after boxes have ruby >= 1.9.3 installed. The automation script can be found [here](https://github.com/oliviazhang0809/grafana/tree/master/librarian-puppet)

[Step 3]
Also you need to check settings in `Vagrantfile`, to see if `environment`, `provider` and `cluster_seed_servers` are set correctly.

[Step 4]
To have machines set up correctly, you need to `vagrant up` puppet (master node) at first and influxdbSeed (the seed of the cluster) the second. It doesn't matter in what order the rest machines are brought up.
Also, please close associated forward host ports on your localhost. By default, it is port 8142 for puppet master, 8003 for grafana, 8004 - 8006 for influxdb nodes.

## Bring up your machines

You can easily bring up virtual boxes by 

    $ vagrant up --provision

If you want to create c3 instances, you can do

    $ vagrant up --provider=openstack

If you are running with c3 instances, you need to set up `cluster_seed_servers` (`$project_root/hieradata/env/dev/common`) after you have influxdbSeed node up so that the client nodes can have a recognizable hostname to join.

## Check Your Handiwork 
To log on to the virtual machines and see the result of your applied Puppet modules, just use standard [Vagrant Multi-VM Environment](http://vagrantup.com/docs/multivm.html) commands, and provide the
proper VM name:

    $ vagrant ssh influxdbSeed

## See Visualized Result!
1. Database cluster - you should be able to see database cluster (under cluster tab) from any of the hosts of three nodes in port 8083, i.e. `http://$seed_server_domain:8083/ `
For example, you can go to `172.16.32.11:8083` if you are running with virtualbox.

2. Grafana - currently grafana is connected with seed influxdb. So you can see the visualization from `$grafana_domain:$grafana_port`.
For example, you can go to `172.16.32.12` if you are running with virtualbox.
Although currently there is nothing inside because we just create our db.
