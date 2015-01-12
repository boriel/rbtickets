

class rails {
    require mysql
    require curl
    require git

    Exec {
        logoutput => true,
        user => 'vagrant',
        environment => 'HOME=/home/vagrant'
    }

    exec { 'gpg_rvm':
        command => '/usr/bin/gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && touch /var/tmp/puppet.gpg_rvm.done',
        timeout => 0,
        creates => '/var/tmp/puppet.gpg_rvm.done'
    }

    exec { 'rvm_install':
        command => '/usr/bin/curl -sSL https://get.rvm.io | bash && touch /var/tmp/puppet.rvm_install.done',
        timeout => 0,
        creates => '/var/tmp/puppet.rvm_install.done',
        require => Exec['gpg_rvm']
    }

    exec { 'ruby_2_2_install':
        command => '/bin/bash -lc -- "rvm install 2.2.0 && touch /var/tmp/puppet.ruby_2_2_install.done"',
        timeout => 0,
        creates => '/var/tmp/puppet.ruby_2_2_install.done',
        require => Exec['rvm_install']
    }

    exec { 'tickets_gemset':
        command => '/bin/bash -lc -- "rvm --create 2.2.0@tickets" && touch /var/tmp/puppet.ticket_gemset.done',
        creates => '/var/tmp/puppet.ticket_gemset.done',
        require => Exec['ruby_2_2_install']
    }

    exec { 'rails_3_2_install':
        command => '/bin/bash -lc -- "rvm use 2.2.0@tickets; gem install rails --version 3.2.16 && touch /var/tmp/puppet.rails_3_2_install.done"',
        timeout => 0,
        require => Exec['tickets_gemset'],
        creates => '/var/tmp/puppet.rails_3_2_install.done'
    }
}

