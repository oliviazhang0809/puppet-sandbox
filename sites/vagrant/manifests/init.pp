# == Class: vagrant
#
# This class is the place to fix minor Vagrant environment issues that may crop
# up with different base boxes.
#
#
class vagrant {

  user { 'puppet':
    ensure  => present,
    comment => 'Puppet',
    gid     => 'puppet',
    require => Group['puppet'],
  }

  group { 'puppet':
    ensure => present,
  }

  user { 'hekadUser':
    ensure  => present,
    comment => 'hekad User',
    gid     => 'hekadUser',
    require => Group['hekadUser'],
  }

  group { 'hekadUser':
    ensure => present,
  }

}
