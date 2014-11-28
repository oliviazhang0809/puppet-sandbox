# == Class: hekad::service
# DO NO CALL DIRECTLY
class hekad::service {

  service { 'hekad':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Class['hekad::install']
  }
}
