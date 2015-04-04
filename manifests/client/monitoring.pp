class nagios_testing::client::monitoring (
  $host_template    = 'base_host',
  $service_template = 'base_service',
  $client_basedir   = "/opt/nagios/auto_configure/${::application_tier}/${::clientcert}"
) {
  @@file { $client_basedir:
    ensure => directory,
    require => File["/opt/nagios/auto_configure/${::application_tier}"],
    owner  => 'root',
    group  => 'root',
    mode   => '2755',
    tag    => "nagios_basedir",
  }

  @@nagios_host { $::fqdn:
    ensure                => present,
    require               => File[$client_basedir],
    alias                 => $::hostname,
    host_name             => $::fqdn,
    use                   => $host_template,
    check_command         => 'check-host-alive',
    parents               => 'master',
    max_check_attempts    => '3',
    register              => '1',
    contact_groups        => 'unix',
    notification_interval => '60',
    notification_period   => '24x7',
    notification_options  => 'd,u,r',
    target                => "${client_basedir}/host_${::clientcert}.cfg",
    tag                   => $::application_tier,
  }

  #  @@nagios_service { "check_ssh_${::hostname}":
  #  ensure              => present,
  #  require             => File[$client_basedir],
  #  use                 => $service_template,
  #  host_name           => $::fqdn,
  #  max_check_attempts  => '4',
  #  check_command       => 'check_ssh',
  #  service_description => 'SSH',
  #  target              => "${client_basedir}/${::clientcert}_check_ssh.cfg",
  #  tag                 => $::application_tier,
  #}

  @@nagios_service { "check_disk_${::hostname}":
    ensure                => present,
    require               => File[$client_basedir],
    use                   => $service_template,
    host_name             => $::fqdn,
    max_check_attempts    => '4',
    check_command         => 'check_nrpe!check_disk',
    service_description   => 'Default Disk Space Check',
    notifications_enabled => '1',
    target                => "${client_basedir}/${::clientcert}_check_disk.cfg",
    tag                   => $::application_tier,
  }

  @@nagios_service { "check_syslog_${::hostname}":
    ensure                => present,
    require               => File[$client_basedir],
    use                   => $service_template,
    host_name             => $::fqdn,
    max_check_attempts    => '4',
    check_command         => 'check_nrpe!check_syslog',
    service_description   => 'Check Syslog',
    notifications_enabled => '1',
    target                => "${client_basedir}/${::clientcert}_check_syslog.cfg",
    tag                   => $::application_tier,
  }

  @@nagios_service { "check_swap_${::hostname}":
    ensure                => present,
    require               => File[$client_basedir],
    use                   => $service_template,
    host_name             => $::fqdn,
    max_check_attempts    => '4',
    check_command         => 'check_nrpe!check_swap',
    service_description   => 'Check Swap',
    notifications_enabled => '1',
    target                => "${client_basedir}/${::clientcert}_check_swap.cfg",
    tag                   => $::application_tier,
  }

  @@nagios_service { "check_dns_${::hostname}":
    ensure                => present,
    require               => File[$client_basedir],
    use                   => $service_template,
    host_name             => $::fqdn,
    max_check_attempts    => '4',
    check_command         => 'check_nrpe!check_dns',
    service_description   => 'Check DNS',
    notifications_enabled => '1',
    target                => "${client_basedir}/${::clientcert}_check_dns.cfg",
    tag                   => $::application_tier,
  }

  @@nagios_service { "check_syslog_proc_${::hostname}":
    ensure                => present,
    require               => File[$client_basedir],
    use                   => $service_template,
    host_name             => $::fqdn,
    max_check_attempts    => '4',
    check_command         => 'check_nrpe!check_syslog_proc',
    service_description   => 'Check Syslog Proc',
    notifications_enabled => '1',
    target                => "${client_basedir}/${::clientcert}_check_syslog_proc.cfg",
    tag                   => $::application_tier,
  }

  @@nagios_service { "check_zombies_${::hostname}":
    ensure                => present,
    require               => File[$client_basedir],
    use                   => $service_template,
    host_name             => $::fqdn,
    max_check_attempts    => '4',
    check_command         => 'check_nrpe!check_zombie_procs',
    service_description   => 'Check Zombie Procs',
    notifications_enabled => '1',
    target                => "${client_basedir}/${::clientcert}_check_zombies.cfg",
    tag                   => $::application_tier,
  }
}
