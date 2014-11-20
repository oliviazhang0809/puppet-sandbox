class apacheimpl(
    $default_vhost = hiera('default_vhost'),
    $servername = hiera('servername'),
    $port = hiera('port'),
    $docroot = hiera('docroot'),
    $error_log_file = hiera('error_log_file'),
    $access_log_file = hiera('access_log_file'),
    $directories = hiera('directories')
    ) {

    class { 'apache': default_vhost => $default_vhost }
    apache::vhost { 'my.grafana.domain':
      servername => $servername,
      port => $port,
      docroot => $docroot,
      error_log_file => $error_log_file,
      access_log_file => $access_log_file,
      directories => $directories,
    }
}
