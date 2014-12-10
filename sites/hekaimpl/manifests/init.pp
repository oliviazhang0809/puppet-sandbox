# Class: hekaimpl
#
# This class implements heka module
class hekaimpl(
    $version = hiera('heka_version'),
    $daemon_version = hiera('daemon_version'),
    $statusd_input_address = hiera('statusd_input_address'),
    $pkg_version = hiera('heka_pkg_version'),
    $maxprocs = hiera('maxprocs'),
    $ticker_interval = hiera('ticker_interval'),
    $emit_in_fields = hiera('emit_in_fields'),
    $influx_output_address = hiera('influx_output_address'),
    $username = hiera('username'),
    $password = hiera('password')
    ) {

    class { 'heka':
      version               => $version,
      daemon_version        => $daemon_version,
      statusd_input_address => $statusd_input_address,
      pkg_version           => $pkg_version,
      maxprocs              => $maxprocs,
      ticker_interval       => $ticker_interval,
      emit_in_fields        => $emit_in_fields,
      influx_output_address => $influx_output_address,
      username              => $username,
      password              => $password,
    }
}
