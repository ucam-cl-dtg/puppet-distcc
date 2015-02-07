class distcc (
  $listen_ip_range,
  $listen_on_ip,
  $use_zeroconf = true,
  
) {
  package {'distcc':
    ensure  => present,
  }

  package {'avahi-daemon':
    ensure  => present,
  }

  service {"distcc":
    enable  => true,
    ensure  => running,
    require => Package["distcc"],
  }

  service {"avahi-daemon":
    enable  => true,
    ensure  => running,
    require => Package["avahi-daemon"],
  }   

  file {"/etc/default/distcc":
    content => template('distcc/distcc-server.erb'),
    ensure  => present,
    notify  => Service["distcc"],
  }
}

