class nagios_testing::server::collect {
  File {
    owner => 'root',
    group => 'root',
    mode  => '2755',
  }

  file { '/opt/nagios/auto_configure':
    ensure  => directory,
    require => Class['nagios_testing::client::agent'],
    purge   => false,
    recurse => false,
  }

  file { '/opt/nagios/auto_configure/development':
    ensure  => directory,
    require => File['/opt/nagios/auto_configure'],
    purge   => true,
    recurse => true,
  }

  file { '/opt/nagios/auto_configure/testing':
    ensure  => directory,
    require => File['/opt/nagios/auto_configure'],
    purge   => true,
    recurse => true,
  }

  file { '/opt/nagios/auto_configure/production':
    ensure  => directory,
    require => File['/opt/nagios/auto_configure'],
    purge   => true,
    recurse => true,
  }


  File <<| tag == "nagios_basedir" |>>
  Nagios_host <<| |>>
  Nagios_service <<| |>>
}
