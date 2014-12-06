# == Class: heka::service
# DO NO CALL DIRECTLY
class heka::service {

  service { 'hekad':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Class['heka::install']
  }
}
