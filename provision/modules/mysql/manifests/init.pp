
class mysql {

    package { 'mysql-server':
        ensure => installed
    }

    package { 'libmysqlclient-dev':
        ensure => installed
    }

}
