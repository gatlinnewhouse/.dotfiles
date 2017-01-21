class i3lock_config {

  file { "/home/$id/lock.sh":
    owner => "$id",
    group => "$id",
    mode => "644",
    source => "puppet:///modules/i3lock_config/lock.sh",
  }

  file { "/home/$id/lockscreen.sh":
    owner => "$id",
    group => "$id",
    mode => "644",
    source => "puppet:///modules/i3lock_config/lockscreen.sh",
  }

  file { "/home/$id/Pictures/lockimage.png":
    owner => "$id",
    group => "$id",
    mode => "644",
    source => "puppet:///modules/i3lock_config/lockimage.png",
  }

  file { "/home/$id/Pictures/lockscreenbkg.png":
    owner => "$id",
    group => "$id",
    mode => "644",
    source => "puppet:///modules/i3lock_config/lockscreenbkg.png",
  }

}
