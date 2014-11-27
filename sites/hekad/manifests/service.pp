# == Class: hekad::service
# DO NO CALL DIRECTLY
class hekad::service {

    exec {'start_service':
        command     => "/bin/bash ${hekad::exec_path} start",
        subscribe   => File['/opt/hekad/shared/init.sh'],
        refreshonly => true,
    }
}
