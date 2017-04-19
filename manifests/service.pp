class secc_nrpe::service {

  service { 'nrpe':
    ensure    => running,
    enable    => true,
    subscribe => [ Class['secc_nrpe::config'], Class['secc_nrpe_checks::config']]
  }

}
