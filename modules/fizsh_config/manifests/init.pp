class fizsh_config {

  file { "/home/$id/.fizsh":
    owner => "$id",
    group => "$id",
    mode => "755",
    ensure => directory,
    recurse => true,
    source => "puppet:///modules/fizsh_config/.fizsh"
  }

}
