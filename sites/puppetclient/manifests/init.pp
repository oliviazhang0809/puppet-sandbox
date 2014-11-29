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

  service { 'puppet':
    ensure  => running,
    enable  => true,
    require => Package[ 'puppet' ],
  }
}
