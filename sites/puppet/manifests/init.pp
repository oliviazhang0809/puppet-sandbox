# == Class: puppet
#
# This class installs and manages the Puppet client daemon.
#
# === Parameters
#
# [*ensure*]
#   What state the package should be in. Defaults to +latest+. Valid values are
#   +present+ (also called +installed+), +absent+, +purged+, +held+, +latest+,
#   or a specific version number.
#
# === Actions
#
# - Install Puppet client package
# - Ensure puppet-agent daemon is running
#
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
    enable  => true,
    ensure  => running,
    require => Package[ 'puppet' ],
  }
}
