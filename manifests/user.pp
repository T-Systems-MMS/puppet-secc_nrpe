class secc_nrpe::user {

  user { $::secc_nrpe::nrpe_user :
    ensure     => 'present',
    gid        => $::secc_nrpe::nrpe_user,
    comment    => 'NRPE user for the NRPE service',
    shell      => '/sbin/nologin',
    home       => $::secc_nrpe::nrpe_homedir,
    managehome => true,
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
  }
}
