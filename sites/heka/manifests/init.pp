# Class: heka
#
# This class installs heka and run heka as daemon in the background
#
# Parameters:
#
# Actions:
#   - Install and config Heka
#   - Start heka daemon
#
class heka (
  $ensure                               = $heka::params::ensure,
  $version                              = $heka::params::version,
  $pkg_version                          = $heka::params::pkg_version,
  $install_from_repository              = $heka::params::install_from_repository,
  $config_path                          = $heka::params::config_path,
  $exec_path                            = $heka::params::exec_path,
  $maxprocs                             = $heka::params::maxprocs,
  $ticker_interval                      = $heka::params::ticker_interval,
  $emit_in_fields                       = $heka::params::emit_in_fields,
  $influx_encoder_type                  = $heka::params::influx_encoder_type,
  $influx_encoder_filename              = $heka::params::influx_encoder_filename,
  $influx_output_type                   = $heka::params::influx_output_type,
  $influx_message_matcher               = $heka::params::influx_message_matcher,
  $influx_output_address                = $heka::params::influx_output_address,
  $encoder                              = $heka::params::encoder,
  $username                             = $heka::params::username,
  $password                             = $heka::params::password,
) inherits heka::params {

  class { 'heka::config': }
  class { 'heka::install': }
  class { 'heka::service': }
}
