# Class: grafanaimpl
#
# This class implements grafana module
#
class grafanaimpl(
    $version = hiera('grafana_version'),
    $influxdb_host = hiera('influxdb_host'),
    $graphite_host = hiera('graphite_host'),
    $influxdb_dbpath = hiera('influxdb_dbpath'),
    $influxdb_user = hiera('influxdb_user'),
    $influxdb_pass = hiera('influxdb_pass'),
    $influxdb_grafana_user = hiera('influxdb_grafana_user'),
    $influxdb_grafana_pass = hiera('influxdb_grafana_pass')
    ) {

    class { 'grafana':
      version               => $version,
      graphite_host         => $graphite_host,
      influxdb_host         => $influxdb_host,
      influxdb_dbpath       => $influxdb_dbpath,
      influxdb_user         => $influxdb_user,
      influxdb_pass         => $influxdb_pass,
      influxdb_grafana_user => $influxdb_grafana_user,
      influxdb_grafana_pass => $influxdb_grafana_pass,
    }
}
