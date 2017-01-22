class rclocal_config {

  file {"/etc/rc.local":
    owner => "root",
    group => "root",
    mode => "644",
    source => "puppet:///modules/rclocal_config/rc.local",
  }

}
