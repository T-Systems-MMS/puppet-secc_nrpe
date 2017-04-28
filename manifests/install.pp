class secc_nrpe::install {

  package { 'nrpe':
    ensure          => installed,
    alias           => 'nrpe',
    install_options => [
      {
        '--enablerepo' => $::secc_nrpe::epelreponame
      }
    ],
  }

  package { 'nagios-plugins-nrpe':
    ensure          => installed,
    install_options => [
      {
        '--enablerepo' => $::secc_nrpe::epelreponame
      }
    ],
  }
}
