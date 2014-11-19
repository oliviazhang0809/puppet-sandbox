#
# site.pp - defines defaults for vagrant provisioning
#
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

hiera_include('classes')

if $hostname == 'puppet' {
  class { 'puppet::server': }
}
