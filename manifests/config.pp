class secc_nrpe::config(
  $server_address,
  $server_port,
  $allowed_hosts,
  $nrpe_user,
  $nrpe_group,
) {

  file { '/etc/nagios/':
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Class['secc_nrpe::install']
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
    owner  => 'nrpe',
    group  => 'nrpe',
    mode   => '0755',
  }

}
