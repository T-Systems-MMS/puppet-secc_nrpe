class secc_nrpe::install(
  $epelreponame,
) {

  package { 'nrpe':
    ensure => installed,
    alias  => 'nrpe',
    install_options => ['--enablerepo', "${epelreponame}"],
  }

  file { '/home/nrpe/':
    ensure  => directory,
    owner   => 'nrpe',
    group   => 'nrpe',
    mode    => '0755',
    recurse => true,
    purge   => true,
  }

}
