# == Class: puppet::params
#
# This class manages the Puppet parameters.
#
# This class file is not called directly.
#

class puppet::params {

  $client_ensure = hiera('client_ensure')
  $server_ensure = hiera('server_ensure')
  $server_package_name = hiera('server_package_name')

}
