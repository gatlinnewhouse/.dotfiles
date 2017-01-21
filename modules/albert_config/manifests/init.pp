class albert_config {

  file { "/home/$id/.config/albert/albert.conf":
    owner => "$id",
    group => "$id",
    mode => "644",
    source => "puppet:///modules/albert_config/albert.conf"
  }

}
