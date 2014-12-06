#!/bin/sh

# install librarian-puppet to auto import modules
which librarian-puppet
if [ $? -ne 0 ]; then
  echo "Installing: gem librarian-puppet"
  sudo gem install librarian-puppet -v=1.3.2
fi
which puppet
if [ $? -ne 0 ]; then
  echo "Installing: gem puppet"
  sudo gem install puppet -v=3.7.2
fi
gem list | grep CFPropertyList
if [ $? -ne 0 ]; then
  echo "Installing: gem CFPropertyList"
  sudo gem install -v=2.2.8 --no-rdoc --no-ri CFPropertyList
fi

echo "Importing modules"
librarian-puppet install --verbose
# change the name of grafana module
mv modules/puppet-grafana modules/grafana
rm -rf modules/puppet-grafana

# install vagrant-openstack-plugin
vagrant plugin list | grep vagrant-openstack-plugin
if [ $? -ne 0 ]; then
  echo "Installing: vagrant plugin: vagrant-openstack-plugin and dependencies"
  sudo gem install fission -v '0.5.0'
  # need to install 0.8.0 to make it work
  sudo gem install -q -v=0.8.0 --no-rdoc --no-ri vagrant-openstack-plugin
  sudo vagrant plugin install vagrant-openstack-plugin --plugin-version 0.8.0
fi

echo "Please enter your provider, v: virtualbox, o: openstack: "
read PROVIDER
export PROVIDER=$PROVIDER

# bring up machines based on provider
if [ "$PROVIDER" = 'o' ]; then
  # TODO: is this necessary?
  # so that all machines will be brought up in order
  vagrant up --provider=openstack puppet
  # I should stop here to collect puppet master fqdn
  # vagrant up --provider=openstack influxdbSeed
  # I should stop here to collect seed-cluster fqdn
  #vagrant up --provider=openstack influxdbChild1
  #vagrant up --provider=openstack influxdbChild2
  #vagrant up --provider=openstack grafana
  #vagrant up --provider=openstack hekad
else
  vagrant up
fi
