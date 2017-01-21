class xinit_config {

  file { "/home/$id/.xinitrc":
    owner => "$id",
    group => "$id",
    mode => "644",
    source => "puppet:///modules/xinit_config/.xinitrc"
  }

}
