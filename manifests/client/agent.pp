class nagios_testing::client::agent (
  $nrpe_group     = 'nagios',
  $nrpe_user      = 'nagios',
  $nrpe_port      = '5666',
  $allowed_hosts,
  $load_warning   = '16,17,18',
  $load_crit      = '20,22,24',
  $ntp_check_host
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
