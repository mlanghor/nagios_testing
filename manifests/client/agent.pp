class nagios_testing::client::agent (
  $nrpe_group  = 'nagios',
  $nrpe_user   = 'nagios',
  $server_port = '5666',
  $allowed_hosts  = '172.21.12.15',
  $load_warning   = '16,17,18',
  $load_crit      = '20,22,24',
  $ntp_check_host = 'fiptime02'
) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { '/opt/nagios':
    ensure => directory,
    mode   => '0755',
  }

  file {'/opt/nagios/conf':
    ensure  => directory,
    mode    => '0755',
    require => File['/opt/nagios'],
  }

  file {'/opt/nagios/conf/nrpe.cfg':
    ensure  => file,
    require => File['/opt/nagios/conf'],
    content => template('nagios_testing/nrpe.erb'),
  }
}
