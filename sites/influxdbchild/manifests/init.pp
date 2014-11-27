# Class: influxdbchild
#
# This class implements influxdb module and config it to join cluster based on seed node
#
class influxdbchild(
    $cluster_seed_servers = hiera('cluster_seed_servers')
    ) {

    # step 1: load and install influxdb
    # step 2: set seed-servers = ["::fqdn for masternode: 8090"]
    # step 3: remove raft dir and restart influxdb

    class {'influxdb':
        cluster_seed_servers => $cluster_seed_servers
    }

    file { 'remove_raft':
        ensure  => absent,
        path    => '/opt/influxdb/shared/data/raft',
        force   => true,
        recurse => true,
        notify  => Service['influxdb'],
    }
}
