class compton_config {

  file {"/home/$id/.compton.conf":
    owner => "$id",
    group => "$id",
    mode => "644",
    source => "puppet:///modules/compton_config/compton.conf"
  }

}
