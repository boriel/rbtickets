
class mysql {

    package { 'mysql-server':
        ensure => installed
    }

    package { 'libmysqlclient-dev':
        ensure => installed
    }

    service { 'mysql':
        ensure => running,
        require => Package['mysql-server']
    }

}
