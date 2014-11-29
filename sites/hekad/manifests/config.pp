# == Class: hekad::config
class hekad::config {

  # [hekad]
  ini_setting { 'maxprocs':
    section => 'hekad',
    setting => 'maxprocs',
    value   => $hekad::maxprocs,
  }

  # [StatAccumInput]
  ini_setting { 'ticker_interval':
    section => 'StatAccumInput',
    setting => 'ticker_interval',
    value   => $hekad::ticker_interval,
  }

  ini_setting { 'emit_in_fields':
    section => 'StatAccumInput',
    setting => 'emit_in_fields',
    value   => $hekad::emit_in_fields,
  }

  # [statmetric-influx-encoder]
  ini_setting { 'influx_encoder_type':
    section => 'statmetric-influx-encoder',
    setting => 'type',
    value   => "\"${hekad::influx_encoder_type}\"",
  }

  ini_setting { 'influx_encoder_filename':
    section => 'statmetric-influx-encoder',
    setting => 'filename',
    value   => "\"${hekad::influx_encoder_filename}\"",
  }

  # [influx]
  ini_setting { 'influx_output_type':
    section => 'influx',
    setting => 'type',
    value   => "\"${hekad::influx_output_type}\"",
  }

  ini_setting { 'influx_message_matcher':
    section => 'influx',
    setting => 'message_matcher',
    value   => "\"${hekad::influx_message_matcher}\"",
  }

  ini_setting { 'influx_output_address':
    section => 'influx',
    setting => 'address',
    value   => "\"${hekad::influx_output_address}\"",
  }

  ini_setting { 'encoder':
    section => 'influx',
    setting => 'encoder',
    value   => "\"${hekad::encoder}\"",
  }

  ini_setting { 'username':
    section => 'influx',
    setting => 'username',
    value   => "\"${hekad::username}\"",
  }

  ini_setting { 'password':
    section => 'influx',
    setting => 'password',
    value   => "\"${hekad::password}\"",
  }

  # defaults for all settings
  Ini_setting {
    ensure  => present,
    path    => $hekad::config_path,
    notify  => Service['hekad'],
    require => [ Package['hekad'], User['hekadUser']]
  }
}
