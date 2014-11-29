# Metrics Setup Instructions

## Introduction

This program is a multi-VM Vagrant-based Puppet development environment used for creating and testing new modules outside of your production environment.
It will set up and configure following machines with customized settings.

* `puppet` - the Puppet master server
* `influxdbSeed` - the influxdb seed node
* `influxdbChild1` - influxdb client nodes
* `influxdbChild2` - influxdb client nodes
* `grafana` - grafana + apache server
* `hekad` - heka daemon

## Initial Setup
### Open Ports

The program will use following forward host ports so please be sure they are available when running the program.

* `8142` for puppet master
* `8003` for grafana
* `8004` for influxdbSeed
* `8005` for influxdbChild1
* `8006` for influxdbChild2
* `8007` for hekad

If any of these ports has special usage, you can always make changes in `vagrantfile`.

### Gem Install

Make sure you have installed required gems.

* [vagrant-openstack-plugin](https://github.com/cloudbau/vagrant-openstack-plugin)

This gem is required when running with c3 instances. You can easily install it by:

```
$ vagrant plugin install vagrant-openstack-plugin
```

* [librarian-puppet](https://github.com/rodjek/librarian-puppet)

This gem can help import modules specified in Puppetfile. You can easily install it by:

```
$ sudo gem install librarian-puppet -v=1.3.2
```
Note, you need to have `puppet` gem in your system to have `librarian-puppet` workable.
If you don't have it, please also install it as well.

```
$ sudo gem install puppet -v=3.7.2
```

Then you can run

```
$ librarian-puppet install
```
to import all modules -- at this time you will have an extra folder `modules` which contains all dependencies.

**TODO**: We will probably automate this in the future after boxes have ruby >= 1.9.3 installed. The automation script is already finished and can be found [here](https://github.com/oliviazhang0809/grafana/tree/master/librarian-puppet)

### Default Value Setup

Please check settings in `Vagrantfile`, to see if the following variables are set as you expected.

`environment`: "dev" -- development environment

`provider`: "virtualbox" -- default provider is set as virtualbox

`cluster_seed_servers`: "influxdbSeed.example.com"

`db_name`: "test2" -- default database

Running with virtualbox, these machines are using following IP addresses and ports:

* _puppet_ - `172.16.32.10:8140`
* _influxdbSeed_ - `172.16.32.11:8083`
* _grafana_ - `172.16.32.12:80`
* _influxdbChild1_ - `172.16.32.13:8083`
* _influxdbChild2_ - `172.16.32.14:8083`

For influxdb cluster, the default username and password are both `root`.

### Environment Installation

To `vagrant up` your c3 boxes, please finish [INSTALLATION](https://github.paypal.com/Stingray/dev-environment/blob/develop/INSTALLATION.md) to have correct environment setup.

### Correct Activation Order

* Puppet master (puppet) node must be activated before all other nodes.
* influxdbSeed must be activated before child nodes (influxdbChild1, influxdbChild2).

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
