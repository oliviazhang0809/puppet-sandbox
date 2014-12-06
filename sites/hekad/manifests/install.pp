# == Class: hekad::install
# DO NO CALL DIRECTLY
class hekad::install {

  file { [ '/etc/hekad', '/opt/hekad', '/opt/hekad/shared', '/var/cache/hekad' ]:
    ensure => directory,
    owner  => 'hekad',
    group  => 'hekad',
    before => Package[ 'hekad' ],
  }

  file { '/etc/init.d/hekad':
    ensure  => file,
    content => hiera('init.sh'),
    owner   => 'hekad',
    group   => 'hekad',
    mode    => '0700',
  }

  # [install hekad]
  $package_provider = 'rpm'
  $package_source = $::architecture ? {
    /64/    => "https://github.com/mozilla-services/heka/releases/download/v${hekad::version}/heka-${hekad::pkg_version}-linux-amd64.rpm",
    default => "https://github.com/mozilla-services/heka/releases/download/v${hekad::version}/heka-${hekad::pkg_version}-linux-386.rpm",
  }

  # get the package
  staging::file { 'hekad-package':
    source   => $package_source,
  }

  # install the package
  package { 'hekad':
    provider => $package_provider,
    source   => '/opt/staging/hekad/hekad-package',
    require  => Staging::File['hekad-package'],
  }

  # [install daemon]
  $daemon_package_source = 'http://libslack.org/daemon/download/daemon-0.6.4-1.x86_64.rpm'

  # get the package
  staging::file { 'daemon-package':
      source   => $daemon_package_source,
  }

  # install the package
  package { 'daemon':
    provider => $package_provider,
    source   => '/opt/staging/hekad/daemon-package',
    require  => Staging::File['daemon-package'],
  }
}
