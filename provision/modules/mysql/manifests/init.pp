
class mysql {

    package { 'rsync':
        ensure => installed,
        require => Exec['apt-get-update'],
        notify => Service['mysql']
    }

    exec { 'mariadb-key':
        command => '/usr/bin/sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db',
        timeout => 0
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

    package { 'mariadb-galera-server':
        ensure => installed,
        require => Package['software-properties-common']
    }

    service { 'mysql':
        ensure => running, 
        require => Package['mariadb-galera-server']
    }

    package { 'libmariadbclient-dev':
        ensure => installed,
        require => Exec['apt-get-update']
    }

    file { '/root/.my.cnf':
        mode => 600,
        owner => root,
        group => root,
        source => 'puppet:///modules/mysql/root-mysql.cnf'
    }

    file { '/etc/mysql/my.cnf':
        mode => 644,
        owner => root,
        group => root,
        source => 'puppet:///modules/mysql/global-my.cnf',
        require => Package['mariadb-galera-server'],
        notify => Service['mysql']
    }

    file { '/etc/mysql/conf.d/mariadb.cnf':
        mode => 644,
        owner => root,
        group => root,
        source => 'puppet:///modules/mysql/mariadb.cnf',
        require => Package['mariadb-galera-server'],
        notify => Service['mysql']
    }

}
