# SecC NRPE Config
class secc_nrpe(
  $epelreponame       = 'epel',
  $server_address     = [undef],
  $server_port        = "5666",
  $allowed_hosts      = ["127.0.0.1,","172.29.70.2"],
  $nrpe_user          = "nrpe",
  $nrpe_group         = "nrpe",
  $nrpe_must_be_root  = false,
    
) {
  
  class { 'secc_nrpe::install':
    epelreponame    => $epelreponame,
  }
  
  class { 'secc_nrpe::config':
    server_address    => $server_address,
    server_port       => $server_port,
    allowed_hosts     => $allowed_hosts,
    nrpe_user         => $nrpe_user,
    nrpe_group        => $nrpe_group,
  }

  include secc_nrpe::user

  class { 'secc_nrpe::permissions':
    nrpe_must_be_root => $nrpe_must_be_root,
  }

  include secc_nrpe::service

}
