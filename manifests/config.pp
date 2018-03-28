class secc_nrpe::config {

  file { $::secc_nrpe::nrpe_homedir:
    ensure  => directory,
    owner   => $::secc_nrpe::nrpe_user,
    group   => $::secc_nrpe::nrpe_group,
    mode    => '0755',
    recurse => true,
    purge   => true,
  }

  file { '/etc/nagios/':
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { '/etc/nagios/nrpe.cfg':
    ensure  => present,
    content => template('secc_nrpe/etc/nagios/nrpe.cfg.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/nagios/'],
  }

  file { '/var/run/nrpe':
    ensure => directory,
    owner  => $::secc_nrpe::nrpe_user,
    group  => $::secc_nrpe::nrpe_group,
    mode   => '0755',
  }
}
