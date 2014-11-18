# == Class: vagrant
#
# This class is the place to fix minor Vagrant environment issues that may crop
# up with different base boxes.
#
#
class vagrant {

  group { 'puppet':
    ensure => present,
  }
}
