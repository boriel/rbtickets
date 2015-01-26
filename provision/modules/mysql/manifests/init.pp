
class mysql {


    exec { 'mariadb-key':
        command => '/usr/bin/sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db',
        timeout => 0,
    }

    file { '/etc/apt/sources.list.d/mariadb.list':
        content => "deb http://ftp.osuosl.org/pub/mariadb/repo/10.0/ubuntu trusty main\n",
        mode => 755,
        owner => root
    }

    exec { 'apt-get-update':
        command => '/usr/bin/sudo apt-get update',
        timeout => 0,
        require => [Exec['mariadb-key'], File['/etc/apt/sources.list.d/mariadb.list']]
    }

    package { 'software-properties-common':
        ensure => installed,
        require => Exec['apt-get-update']
    }

    package { 'mariadb-server':
        ensure => installed,
        require => Package['software-properties-common']
    }

    service { 'mysql':
        ensure => running, 
        require => Package['mariadb-server']
    }

    package { 'libmariadbclient-dev':
        ensure => installed,
        require => Exec['apt-get-update']
    }

}
