#
# site.pp - defines defaults for vagrant provisioning
#

stage { 'pre': before => Stage['main'] }

class { 'repos':   stage => 'pre' }
class { 'vagrant': stage => 'pre' }

class { 'puppet': }
class { 'networking': }

if $hostname == 'puppet' {
  class { 'puppet::server': }
}
