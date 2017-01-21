class xresources_config {

  file { "/home/$id/.Xresources":
    owner => "$id",
    group => "$id",
    mode => "644",
    source => "puppet:///modules/xresources_config/,Xresources",
  }

}
