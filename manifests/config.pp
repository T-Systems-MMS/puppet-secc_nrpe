class secc_nrpe::config(
  $server_address,
  $setServerAddress,
  $server_port,
  $allowed_hosts,
  $nrpe_user,
  $nrpe_group,
  $admininterface_xen0,
  $admininterface_nr,
  
) {
  
  if ( $setServerAddress) {
    if ( $::virtual == 'xen0' ) {
      $string = "@ipaddress_${admininterface_xen0}"
      $adminip = inline_template("<%= ${string} %>")
    }
    else {
      $ifs = split($::interfaces, ',')
      $string = "@ipaddress_${ifs[$admininterface_nr]}"
      $adminip = inline_template("<%= ${string} %>")
    }
  }

  file { '/etc/nagios/':
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Class['secc_nrpe::install']
  }

  file { '/etc/nagios/nrpe.cfg':
    ensure  => present,
    content => template('secc_nrpe/etc/nagios/nrpe.cfg.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/nagios/'],
  }

  file { '/var/run/nrpe':
    ensure => directory,
    owner  => 'nrpe',
    group  => 'nrpe',
    mode   => '0755',
  }
  
 }
