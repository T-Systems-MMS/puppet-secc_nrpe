class secc_nrpe::install(
  $epelreponame,
) {

  package { 'nrpe':
    ensure => installed,
    alias  => 'nrpe',
    install_options => [ { '--enablerepo' => "${epelreponame}" } ],
  }
  
  package { 'nagios-plugins-nrpe':
    ensure => installed,
    install_options => [ { '--enablerepo' => "${epelreponame}" } ],
  }
}
