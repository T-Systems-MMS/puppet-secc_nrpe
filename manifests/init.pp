# SecC NRPE Config
class secc_nrpe(
  $epelreponame             = $::secc_nrpe::params::epelreponame,
  $server_address           = $::secc_nrpe::params::server_address,
  $server_port              = $::secc_nrpe::params::server_port,
  $allowed_hosts            = $::secc_nrpe::params::allowed_hosts,
  $nrpe_user                = $::secc_nrpe::params::nrpe_user,
  $nrpe_group               = $::secc_nrpe::params::nrpe_group,
  $nrpe_must_be_root        = $::secc_nrpe::params::nrpe_must_be_root,
  $define_nrpe_custom_root  = $::secc_nrpe::params::define_nrpe_custom_root,
  $nrpe_custom_root         = $::secc_nrpe::params::nrpe_custom_root,
) inherits secc_nrpe::params {

  $_allowed_hosts = join($allowed_hosts, ',')

Class['secc_nrpe::install'] -> Class['secc_nrpe::user']
Class['secc_nrpe::install'] -> Class['secc_nrpe::config'] ~> Class['secc_nrpe::service']

  contain secc_nrpe::install
  contain secc_nrpe::config
  contain secc_nrpe::user
  contain secc_nrpe::permissions
  contain secc_nrpe::service

}
