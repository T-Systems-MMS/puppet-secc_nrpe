class secc_nrpe::permissions {

  file { '/etc/sudoers.d/nrpe':
    ensure   => present,
    content  => template('secc_nrpe/etc/sudoers.d/nrpe.erb'),
    owner    => 'root',
    group    => 'root',
    mode     => '0440',
    selrange => 's0',
    selrole  => 'object_r',
    seltype  => 'etc_t',
    seluser  => 'unconfined_u',
  }

  File['/etc/sudoers.d/nrpe']
  { validate_cmd => '/usr/sbin/visudo -c -f %' }
}
