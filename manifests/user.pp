class secc_nrpe::user {

  # GID 10000 - nrpe
  group { 'nrpe':
    ensure => 'present',
    gid    => '10000',
    name   => 'nrpe',
  }

  # UID 10000 - nrpe
  user { 'nrpe':
    ensure     => 'present',
    uid        => '10000',
    gid        => 'nrpe',
    comment    => 'NRPE user for the NRPE service',
    shell      => '/sbin/nologin',
    home       => '/home/nrpe',
    managehome => true,
    require    => Group['nrpe'],
  }
}
