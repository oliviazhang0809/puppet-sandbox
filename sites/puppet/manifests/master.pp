# Class: puppet::master
#
# This class installs and manages the Puppet server daemon.
#
class puppet::master(
  $ensure = hiera('server_version')
  ){

  include puppet

  package { 'puppet-server':
    ensure => $ensure,
  }

  file { [ '/var/www/puppet', '/var/www/puppet/modules' ]:
    ensure => directory,
    owner  => 'puppet',
    group  => 'puppet',
    before => Package[ 'puppet-server' ],
  }

  file { 'autosign.conf':
    path    => '/var/www/puppet/autosign.conf',
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    content => hiera('autosign.conf'),
    require => Package[ 'puppet-server' ],
  } ->

  # puppet master need to be started at least once to create the SSL certificates to configure Apache
  exec {'start_puppetmaster':
    command => 'sudo service puppetmaster start',
  }
}
