# == Class: heka::config
class heka::config {

  # [hekad]
  ini_setting { 'maxprocs':
    section => 'hekad',
    setting => 'maxprocs',
    value   => $heka::maxprocs,
  }

  # [StatAccumInput]
  ini_setting { 'ticker_interval':
    section => 'StatAccumInput',
    setting => 'ticker_interval',
    value   => $heka::ticker_interval,
  }

  ini_setting { 'emit_in_fields':
    section => 'StatAccumInput',
    setting => 'emit_in_fields',
    value   => $heka::emit_in_fields,
  }

  # [statmetric-influx-encoder]
  ini_setting { 'influx_encoder_type':
    section => 'statmetric-influx-encoder',
    setting => 'type',
    value   => "\"${heka::influx_encoder_type}\"",
  }

  ini_setting { 'influx_encoder_filename':
    section => 'statmetric-influx-encoder',
    setting => 'filename',
    value   => "\"${heka::influx_encoder_filename}\"",
  }

  # [influx]
  ini_setting { 'influx_output_type':
    section => 'influx',
    setting => 'type',
    value   => "\"${heka::influx_output_type}\"",
  }

  ini_setting { 'influx_message_matcher':
    section => 'influx',
    setting => 'message_matcher',
    value   => "\"${heka::influx_message_matcher}\"",
  }

  ini_setting { 'influx_output_address':
    section => 'influx',
    setting => 'address',
    value   => "\"${heka::influx_output_address}\"",
  }

  ini_setting { 'encoder':
    section => 'influx',
    setting => 'encoder',
    value   => "\"${heka::encoder}\"",
  }

  ini_setting { 'username':
    section => 'influx',
    setting => 'username',
    value   => "\"${heka::username}\"",
  }

  ini_setting { 'password':
    section => 'influx',
    setting => 'password',
    value   => "\"${heka::password}\"",
  }

  # defaults for all settings
  Ini_setting {
    ensure  => present,
    path    => $heka::config_path,
    notify  => Service['hekad'],
    require => [ Package['hekad'], User['hekad']]
  }
}
