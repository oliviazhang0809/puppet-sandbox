#!/bin/sh
# Only needed when you want to bring up c3 instances
# basic setup
DIR=`pwd`
BIN_DIR=`dirname $0`
. $BIN_DIR/setup.sh
# install vagrant-openstack-plugin
vagrant plugin list | grep vagrant-openstack-plugin
if [ $? -ne 0 ]; then
  echo "Installing: vagrant plugin: vagrant-openstack-plugin and dependencies"
  sudo gem install fission -v '0.5.0'
  # need to install 0.8.0 to make it work
  sudo gem install -q -v=0.8.0 --no-rdoc --no-ri vagrant-openstack-plugin
  sudo vagrant plugin install vagrant-openstack-plugin --plugin-version 0.8.0
fi

# so that all machines will be brought up in order
vagrant up --provision --provider=openstack puppet
vagrant up --provision --provider=openstack influxdbSeed
# I should stop here to collect seed-cluster fqdn
#vagrant up --provision --provider=openstack influxdbChild1
#vagrant up --provision --provider=openstack influxdbChild2
#vagrant up --provision --provider=openstack grafana
#vagrant up --provision --provider=openstack hekad