
require mysql

file { '/etc/mysql/conf.d/mariadb.cnf':
    mode => 644,
    owner => root,
    group => root,
    source => 'puppet:///modules/mysql/mariadb.cnf',
    require => Package['mariadb-galera-server'],
}

exec { 'set-wsrep-address':
    command => "/bin/sed -i 's/wsrep_node_address=.*/wsrep_node_address=${::hostname}/' /etc/mysql/conf.d/mariadb.cnf",
    require => File['/etc/mysql/conf.d/mariadb.cnf']
}

# master node
node 'mysql1.localnet' {

    exec { 'configure-master-node':
        command => "/bin/sed -i 's/gcomm:\\/\\/.*$/gcomm:\\/\\//' /etc/mysql/conf.d/mariadb.cnf",
        require => Exec['set-wsrep-address']
    }

    exec { 'mysql-restart':
        command => '/etc/init.d/mysql restart',
        require => Exec['configure-master-node'],
        timeout => 0
    }

}


node default {
    
    exec { 'mysql-restart':
        command => '/etc/init.d/mysql restart',
        require => Exec['set-wsrep-address']
    }
}


