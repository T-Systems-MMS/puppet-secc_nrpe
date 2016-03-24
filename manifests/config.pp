class secc_nrpe::config {

  file { '/etc/nagios/':
    ensure  => directory,
    recurse => true,
    purge   => true,
  }

  file { '/etc/nagios/nrpe.cfg':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/secc_nrpe/etc/nagios/nrpe.cfg',
    require => File['/etc/nagios/'],
  }

  file { '/etc/nrpe.d/':
    ensure  => directory,
    recurse => true,
    purge   => true,
  }

  file { '/etc/nrpe.d/general.cfg':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/secc_nrpe/etc/nrpe.d/general.cfg',
    require => File['/etc/nrpe.d/'],
  }

}
