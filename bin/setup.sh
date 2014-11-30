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
echo "Importing modules"
librarian-puppet install
# change the name of grafana module
mv modules/puppet-grafana modules/grafana
rm -rf modules/puppet-grafana

echo "Please enter your provider, v: virtualbox, o: openstack: "
read -sr PROVIDER
export PROVIDER=$PROVIDER