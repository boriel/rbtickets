
class mysql {

    package { 'mysql-server':
        ensure => installed
    }

    packate { 'libmysqlclient-dev':
        ensure => installed
    }

}
