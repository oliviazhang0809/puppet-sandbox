# == Class: hekad::install
# DO NO CALL DIRECTLY
class hekad::install {

  file { [ '/etc/hekad', '/opt/hekad', '/opt/hekad/shared', '/var/cache/hekad' ]:
    ensure => directory,
    owner  => 'hekadUser',
    group  => 'hekadUser',
    before => Package[ 'hekad' ],
  }

  file { '/etc/init.d/hekad':
    content => template('hekad/init.sh'),
    owner   => 'hekadUser',
    group   => 'hekadUser',
    before  => Exec['create_service']
  }

  exec {'create_service':
    command => 'chmod +x /etc/init.d/hekad',
  }

  package { 'hekad':
    ensure => hekad::ensure,
  }

  # [install hekad]
  $package_provider = 'rpm'
  $package_source = $::architecture ? {
    /64/    => "https://github.com/mozilla-services/heka/releases/download/v${hekad::version}/heka-0_8_0-linux-amd64.rpm",
    default => "https://github.com/mozilla-services/heka/releases/download/v${hekad::version}/heka-0_8_0-linux-386.rpm",
  }

  # get the package
  staging::file { 'hekad-package':
    source   => $package_source,
  }

  # install the package
  Package['hekad']{
    provider => $package_provider,
    source   => '/opt/staging/hekad/hekad-package',
    require  => Staging::File['hekad-package'],
  }

  # [install daemon]
  package { 'daemon':
    ensure => hekad::ensure,
  }

  $daemon_package_source = 'http://libslack.org/daemon/download/daemon-0.6.4-1.x86_64.rpm'
  # get the package
  staging::file { 'daemon-package':
      source   => $daemon_package_source,
  }

  # install the package
  Package['daemon']{
    provider => $package_provider,
    source   => '/opt/staging/hekad/daemon-package',
    require  => Staging::File['daemon-package'],
  }
}