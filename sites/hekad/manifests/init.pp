# Class: hekad
#
# This class installs heka and run heka as daemon in the background
#
# Parameters:
#
# Actions:
#   - Install and config Heka
#   - Start heka daemon
#
class hekad (
  $ensure                               = $hekad::params::ensure,
  $version                              = $hekad::params::version,
  $pkg_version                          = $hekad::params::pkg_version,
  $install_from_repository              = $hekad::params::install_from_repository,
  $config_path                          = $hekad::params::config_path,
  $exec_path                            = $hekad::params::exec_path,
  $maxprocs                             = $hekad::params::maxprocs,
  $ticker_interval                      = $hekad::params::ticker_interval,
  $emit_in_fields                       = $hekad::params::emit_in_fields,
  $influx_encoder_type                  = $hekad::params::influx_encoder_type,
  $influx_encoder_filename              = $hekad::params::influx_encoder_filename,
  $influx_output_type                   = $hekad::params::influx_output_type,
  $influx_message_matcher               = $hekad::params::influx_message_matcher,
  $influx_output_address                = $hekad::params::influx_output_address,
  $encoder                              = $hekad::params::encoder,
  $username                             = $hekad::params::username,
  $password                             = $hekad::params::password,
) inherits hekad::params {

  class { 'hekad::config': }
  class { 'hekad::install': }
  class { 'hekad::service': }
}
