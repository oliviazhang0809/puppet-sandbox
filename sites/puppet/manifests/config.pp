# == Class: puppet::config
# DO NO CALL DIRECTLY
class puppet::config {

  file { 'puppet.conf':
    ensure  => present,
    content => template('puppet/puppet.conf.erb'),
    path    => '/etc/puppet/puppet.conf',
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    require => Class[ 'puppet::install' ],
    notify  => Class[ 'puppet::service' ],
  }
}
