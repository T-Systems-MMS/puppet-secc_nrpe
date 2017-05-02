class secc_nrpe::user {

  user { $::secc_nrpe::nrpe_user :
    ensure     => 'present',
    gid        => $::secc_nrpe::nrpe_user,
    comment    => 'NRPE user for the NRPE service',
    shell      => '/sbin/nologin',
    home       => "/home/${::secc_nrpe::nrpe_user}",
    managehome => true,
    require    => Class['secc_nrpe::install'],
  }

  group { $::secc_nrpe::nrpe_group :
    ensure  => 'present',
    name    => $::secc_nrpe::nrpe_group,
    require => User[$::secc_nrpe::nrpe_user],
  }

  # ensure security for dependency user nagios
  user { 'nagios':
    ensure           => 'present',
    home             => '/var/spool/nagios',
    password         => '!!',
    password_min_age => '-1',
    password_max_age => '-1',
    shell            => '/sbin/nologin',
    require          => Class['secc_nrpe::install'],
  }
}
