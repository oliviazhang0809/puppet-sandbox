# == Class: heka::params
# DO NOT CALL DIRECTLY
class heka::params {

    $ensure                               = 'installed'
    $version                              = '0.8.0'
    $pkg_version                          = '0_8_0'
    $install_from_repository              = false
    $config_path                          = '/opt/hekad/shared/config.toml'
    $exec_path                            = '/opt/hekad/shared/init.sh'

    # [hekad]
    $maxprocs                             = 1

    # [StatAccumInput]
    $ticker_interval                      = 1
    $emit_in_fields                       = true

    # [statmetric-influx-encoder]
    $influx_encoder_type                  = 'SandboxEncoder'
    $influx_encoder_filename              = 'lua_encoders/statmetric_influx.lua'

    # [influx]
    $influx_output_type                   = 'HttpOutput'
    $influx_message_matcher               = "Type == 'heka.statmetric'"
    $influx_output_address                = 'localhost'
    $encoder                              = 'statmetric-influx-encoder'
    $username                             = 'root'
    $password                             = 'root'

}
