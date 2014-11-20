class influxdbcommon {
    include 'influxdb'

    # remove raft dir and restart
    file { '/opt/influxdb/shared/data/raft':
        ensure => absent,
        force   => true,
        recurse => true,
        notify  => Service['influxdb'],
    }
}
