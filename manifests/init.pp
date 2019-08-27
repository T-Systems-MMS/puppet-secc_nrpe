# SecC NRPE Config
class secc_nrpe(
  String $epelreponame,
  String $server_address,
  String $server_port,
  Array $allowed_hosts,
  String $nrpe_user,
  String $nrpe_group,
  String $nrpe_homedir,
  Integer $command_timeout,
  Boolean $nrpe_must_be_root,
  Optional[Array] $nrpe_custom_root = [undef],
)  {

  $_allowed_hosts = join($allowed_hosts, ',')

  Class['secc_nrpe::install']
  -> Class['secc_nrpe::user']
  -> Class['secc_nrpe::config']
  ~> Class['secc_nrpe::service']

  contain secc_nrpe::install
  contain secc_nrpe::config
  contain secc_nrpe::user
  contain secc_nrpe::permissions
  contain secc_nrpe::service

}
