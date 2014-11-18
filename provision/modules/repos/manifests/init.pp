# == Class: repos
#
# This class loads the relevant distribution-specific package repository
# manifests and would be the place to configure any other custom repos you
# may want.
#

class repos {

  case $::osfamily {
    'redhat': {
      class { 'repos::yum': }
    }
    default: {
      fail("Module '${module_name}' is not currently supported by Puppet Sandbox on ${::operatingsystem}")
    }
  }
}
