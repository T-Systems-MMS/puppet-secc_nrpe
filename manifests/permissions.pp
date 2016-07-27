class secc_nrpe::permissions(
  $nrpe_must_be_root,
  $define_nrpe_custom_root,
  $nrpe_custom_root,
) {

  ensure_packages( ['sudo'] )

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
