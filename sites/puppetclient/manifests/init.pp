# == Class: puppetclient
#
# This class installs and manages the Puppet client daemon.
#

class puppetclient(
  $ensure = hiera('client_ensure')
  ){

  package { 'puppet':
    ensure => $ensure,
  }

  exec { 'start_puppet':
    command => '/bin/sed -i /etc/default/puppet -e "s/START=no/START=yes/"',
    onlyif  => '/usr/bin/test -f /etc/default/puppet',
    require => Package[ 'puppet' ],
    before  => Service[ 'puppet' ],
  }

  service { 'puppet':
    ensure  => running,
    enable  => true,
    require => Package[ 'puppet' ],
  }
}
