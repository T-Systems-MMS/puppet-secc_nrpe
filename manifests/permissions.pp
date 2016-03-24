class secc_nrpe::permissions {

  ensure_packages( ['sudo'] )

  file { '/etc/sudoers.d/nrpe':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
    source => 'puppet:///modules/secc_nrpe/etc/sudoers.d/nrpe',
    selrange => 's0',
    selrole  => 'object_r',
    seltype  => 'etc_t',
    seluser  => 'unconfined_u',
    #require => Class['sudoers'],
  }

}
