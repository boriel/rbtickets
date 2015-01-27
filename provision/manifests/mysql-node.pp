
require mysql

file { '/etc/mysql/conf.d/mariadb.cnf':
    mode => 644,
    owner => root,
    group => root,
    source => 'puppet:///modules/mysql/mariadb.cnf',
    require => Package['mariadb-galera-server'],
    notify => Service['mysql']
}

# master node
node 'mysql1.localnet' {

    exec { 'configure-master-node':
        command => "/bin/sed -i 's/gcomm:\\/\\/.*$/gcomm:\\/\\//' /etc/mysql/conf.d/mariadb.cnf"
    }

    exec { 'mysql-restart':
        command => '/etc/init.d/mysql restart',
        require => Exec['configure-master-node']
    }

}


node default {
    
    exec { 'mysql-restart':
        command => '/etc/init.d/mysql restart'
    }
}


