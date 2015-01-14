
class nginx {
    package { 'nginx':
        ensure => installed
    }

    file { '/etc/nginx/sites-available/tickets':
        source => 'puppet:///modules/nginx/tickets',
        mode => 755,
        owner => 'root',
        group => 'root',
        require => Package['nginx']
    }

    file { '/etc/nginx/sites-enabled/tickets':
        ensure => 'link',
        target => '/etc/nginx/sites-available/tickets',
        require => File['/etc/nginx/sites-available/tickets']
    }

    file { '/etc/nginx/sites-enabled/default':
        ensure => absent,
        require => File['/etc/nginx/sites-enabled/tickets']
    }

    service { 'nginx':
        ensure => running,
        require => [File['/etc/nginx/sites-enabled/default'], File['/etc/nginx/sites-enabled/tickets']]
    } 

}


