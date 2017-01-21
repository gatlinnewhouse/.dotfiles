class xbindkeys_config {

  file { "/home/$id/.xbindkeysrc":
    owner => "$id",
    group => "$id",
    mode => "644",
    source => "puppet:///modules/xbindkeys_config/.xbindkeysrc",
  }

}
