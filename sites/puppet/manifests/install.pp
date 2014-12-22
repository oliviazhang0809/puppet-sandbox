# == Class: puppet::install
# DO NO CALL DIRECTLY
class puppet::install (
  $ensure = hiera('puppet_version')
  ){

  package { 'puppet':
    ensure => $ensure,
  }
}
