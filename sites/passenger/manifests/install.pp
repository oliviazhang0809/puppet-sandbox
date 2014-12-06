# == Class: passenger::install
# DO NO CALL DIRECTLY
class passenger::install (
  $passenger_version = hiera('passenger_version')
  ) {

  package { [ 'httpd', 'httpd-devel', 'mod_ssl', 'ruby-devel', 'libcurl-devel' ]:
    ensure   => 'installed',
  }

  package { 'rubygems':
    ensure => 'installed',
    before => [ Package['rack'], Package['passenger'] ],
  }

  package { 'rack':
    ensure   => 'installed',
    provider => gem,
  }

  package { 'passenger':
    ensure   => $passenger_version,
    provider => gem,
  }

  file { [ '/usr/share/puppet/rack', '/usr/share/puppet/rack/puppetmasterd', '/usr/share/puppet/rack/puppetmasterd/public', '/usr/share/puppet/rack/puppetmasterd/tmp' ]:
    ensure => 'directory',
  }
}
