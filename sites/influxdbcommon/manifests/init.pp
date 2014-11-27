# Class: influxdbcommon
#
# This class implements influxdb module and config it as seed node of cluster
#
class influxdbcommon {

    # step 1: load and install influxdb
    # step 2: remove raft dir and restart influxdb

    class {'influxdb': }

    file { '/opt/influxdb/shared/data/raft':
        ensure  => absent,
        force   => true,
        recurse => true,
        notify  => Service['influxdb'],
    }
}
