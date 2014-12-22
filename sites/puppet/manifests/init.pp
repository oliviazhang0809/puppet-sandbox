# == Class: puppet
#
# This class installs and manages the Puppet client daemon.
#
class puppet {

  include puppet::install
  include puppet::config
  include puppet::service
}
