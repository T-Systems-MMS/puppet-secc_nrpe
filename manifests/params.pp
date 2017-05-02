class secc_nrpe::params (
  $epelreponame            = 'epel',
  $server_address          = $::ipaddress,
  $server_port             = '5666',
  $allowed_hosts           = ['127.0.0.1', '172.29.70.2'],
  $nrpe_user               = 'nrpe',
  $nrpe_group              = 'nrpe',
  $nrpe_must_be_root       = false,
  $define_nrpe_custom_root = false,
  $nrpe_custom_root        = [undef],
  ) {

}
