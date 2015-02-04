class nagios_testing::client::agent {

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
