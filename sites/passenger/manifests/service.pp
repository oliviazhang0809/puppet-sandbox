# == Class: passenger::service
# DO NO CALL DIRECTLY
class passenger::service {

  #require passenger::config

  $activated_httpd = 'chkconfig httpd on'

  service { 'httpd':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  } ->

  exec {'chkconfig':
    command => $activated_httpd,
  }
}
