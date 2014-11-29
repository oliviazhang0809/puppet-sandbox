# Class: puppetmaster
#
# This class installs and manages the Puppet server daemon.
#
class puppetmaster(
    $ensure       = hiera('server_ensure'),
    $package_name = hiera('server_package_name')
    ){

  file { [ '/etc/puppet', '/etc/puppet/modules' ]:
    ensure => directory,
    owner  => 'puppet',
    group  => 'puppet',
    before => Package[ 'puppetmaster' ],
  }

  package { 'puppetmaster':
    ensure => $ensure,
    name   => $package_name,
  }

  file { 'puppet.conf':
    path    => '/etc/puppet/puppet.conf',
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    source  => 'puppet:///modules/puppet/puppet.conf',
    require => Package[ 'puppetmaster' ],
    notify  => Service[ 'puppetmaster' ],
  }

  file { 'autosign.conf':
    path    => '/etc/puppet/autosign.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => '*',
    require => Package[ 'puppetmaster' ],
  }

  service { 'puppetmaster':
    ensure => running,
    enable => true,
  }
}
