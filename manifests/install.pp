class secc_nrpe::install {

  package { 'nrpe':
    ensure  => installed,
    alias   => 'nrpe',
    require => Class['secc_nrpe::user']
  }

  file { '/home/nrpe/':
    ensure  => directory,
    owner   => 'nrpe',
    group   => 'nrpe',
    mode    => '0755',
    recurse => true,
    purge   => true,
    require => Package['nrpe']
  }

  file { '/home/nrpe/bin/':
    ensure  => directory,
    owner   => 'nrpe',
    group   => 'nrpe',
    mode    => '0750',
    recurse => true,
    purge   => true,
    force   => true,
    source  => 'puppet:///modules/secc_nrpe/home/nrpe/bin',
    require => File['/home/nrpe/'],
  }

}
