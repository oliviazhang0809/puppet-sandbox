# == Class: puppet
#
# This class installs and manages the Puppet client daemon.
#

class puppet(
  $ensure = $puppet::params::client_ensure
) inherits puppet::params {

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
