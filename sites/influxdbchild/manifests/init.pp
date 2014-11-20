class influxdbchild {
    include 'influxdb'

    # replace the value of seed-servers = []
    file { '/opt/influxdb/shared/config.toml':
        ensure => present,
    }->
    file_line { 'replace content of seed server':
      path => '/opt/influxdb/shared/config.toml',
      line => 'seed-servers = ["influxdbSeed.example.com:8090"]',
      match   => "^seed-servers.=.*",
    }

    # remove the raft dir
    file { '/opt/influxdb/shared/data/raft':
        ensure => absent,
        force   => true,
        recurse => true,
        notify  => Service['influxdb'],
    }
}
