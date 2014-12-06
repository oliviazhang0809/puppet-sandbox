# == Class: puppet::install
# DO NO CALL DIRECTLY
class puppet::install (
  $ensure = hiera('client_version')
  ){

  package { 'puppet':
    ensure => $ensure,
  }
}
