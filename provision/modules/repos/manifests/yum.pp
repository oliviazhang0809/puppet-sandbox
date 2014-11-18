# == Class: repos::yum
#
# This class installs the Puppet Labs YUM repository.
#
# === Parameters
#
# === Actions
#
# - Install puppetlabs repository
# - Perform initial sync to update package database
#
#
class repos::yum {

  $os_release_major_version = regsubst($operatingsystemrelease, '^(\d+).*$', '\1')

  file { 'puppetlabs.repo':
    ensure  => present,
    path    => '/etc/yum.repos.d/puppetlabs.repo',
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('repos/puppetlabs.repo.erb'),
  }

  exec { 'yum_makecache':
    command     => '/usr/bin/yum makecache',
    subscribe   => File[ 'puppetlabs.repo' ],
    refreshonly => true,
  }

}
