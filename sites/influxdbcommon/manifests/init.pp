# Class: influxdbcommon
#
# This class implements influxdb module and config it as seed node of cluster
#
class influxdbcommon (
    $influx_version = hiera('influx_version')
  ){

    # step 1: load and install influxdb
    # step 2: remove raft dir and restart influxdb

    class {'influxdb':
      version   => $influx_version,
    }

    file { '/opt/influxdb/shared/data/raft':
        ensure  => absent,
        force   => true,
        recurse => true,
        notify  => Service['influxdb'],
    }
}
