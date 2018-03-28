class secc_nrpe::service {

  service { 'nrpe':
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
    enable     => true,
  }

}
