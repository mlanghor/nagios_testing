class nagios_testing::server::collect {
  notice("hellooooo")
  File {
    owner => 'root',
    group => 'root',
    mode  => '2750',
  }

  file { '/opt/nagios/auto_configure':
    require => Class['nagios_testing::client::agent'],
    purge   => true,
    recurse => true,
  }

  Nagios_host <<| |>>
  Nagios_service <<| |>>
}
