# Class: hekadimpl
#
# This class implements hekad module
#
class hekadimpl(
    $maxprocs = hiera('maxprocs'),
    $ticker_interval = hiera('ticker_interval'),
    $emit_in_fields = hiera('emit_in_fields'),
    $influx_output_address = hiera('influx_output_address'),
    $username = hiera('username'),
    $password = hiera('password')
    ) {

    class { 'hekad':
      maxprocs              => $maxprocs,
      ticker_interval       => $ticker_interval,
      emit_in_fields        => $emit_in_fields,
      influx_output_address => $influx_output_address,
      username              => $username,
      password              => $password,
    }
}