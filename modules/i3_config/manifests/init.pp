class i3_config {

  file {"/home/$id/.config/i3/config":
    owner => "$id",
    group => "$id",
    mode => "644",
    source => "puppet:///modules/i3_config/config"
  }

}
