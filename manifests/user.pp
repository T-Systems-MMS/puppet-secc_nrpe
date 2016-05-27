class secc_nrpe::user {

  user { 'nrpe':
    ensure     => 'present',
    gid        => 'nrpe',
    comment    => 'NRPE user for the NRPE service',
    shell      => '/sbin/nologin',
    home       => '/home/nrpe',
    managehome => true,
    require    => Package['nrpe'],
  }

  group { 'nrpe':
    ensure  => 'present',
    name    => 'nrpe',
    require => User['nrpe'],
  }

  # ensure security for dependency user nagios
  user { 'nagios':
    ensure            => 'present',
    home              => '/var/spool/nagios',
    password          => '!!',
    password_min_age  => '-1',
    password_max_age  => '-1',
    shell             => '/sbin/nologin',
    require           => Package['nrpe'],
  }
}
