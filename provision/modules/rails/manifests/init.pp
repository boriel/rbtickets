
require curl
require git

class rails {

    Exec {
        logoutput => true
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
        command => '/usr/local/rvm/bin/rvm install 2.2.0 && touch /var/tmp/puppet.ruby_2_2_install.done',
        timeout => 0,
        creates => '/var/tmp/puppet.ruby_2_2_install.done',
        require => Exec['rvm_install']
    }
}

