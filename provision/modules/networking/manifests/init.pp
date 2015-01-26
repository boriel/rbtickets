
# common networking configuration

class networking {

    file { '/etc/hosts':
        source => 'puppet:///modules/networking/hosts',
        owner => root,
        group => root, 
        mode => 644
    }
}

