#
# nodes.pp - template used by puppet
#

# MASTER
node 'puppet' { }

##### CLIENTS
# influxdbSeed: influxdb seed node
# grafana: grafana + apache server
# influxdbChild1, influxdbChild2: influxdb client nodes

node 'influxdbSeed' {
  class { 'influxdb': }
  file { '/opt/influxdb/shared/data/raft':
        ensure => absent,
        force   => true,
        recurse => true,
        notify  => Service['influxdb'],
    }
  include 'staging'
}

node 'grafana' {
  class {'grafana':
    influxdb_host         => '172.16.32.11',
    influxdb_dbpath       => '/db/test2',
    influxdb_user         => 'root',
    influxdb_pass         => 'root',
    influxdb_grafana_user => 'root',
    influxdb_grafana_pass => 'root',
  }

  class { 'apache': default_vhost => false }
  apache::vhost { 'my.grafana.domain':
    servername      => 'my.grafana.domain',
    port            => 80,
    docroot         => '/opt/grafana',
    error_log_file  => 'grafana_error.log',
    access_log_file => 'grafana_access.log',
    directories     => [
      {
        path           => '/opt/grafana',
        options        => [ 'None' ],
        allow          => 'from All',
        allow_override => [ 'None' ],
        order          => 'Allow,Deny',
      }
    ]
  }
}

node 'influxdbChild1', 'influxdbChild2' {
    class {'influxdb': }
    file { '/opt/influxdb/shared/config.toml':
        ensure => present,
    }->
    file_line { 'replace content of seed server':
      path => '/opt/influxdb/shared/config.toml',
      line => 'seed-servers = ["influxdbSeed.example.com:8090"]',
      match   => "^seed-servers.=.*",
    }
    file { 'raft':
        ensure => absent,
        path => '/opt/influxdb/shared/data',
        force   => true,
        recurse => true,
        notify  => Service["influxdb"],
    }
}
