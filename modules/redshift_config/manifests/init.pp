class redshift_config {

  file { "/home/$id/.config/redshift.conf":
    owner => "$id",
    group => "$id",
    mode => "644",
    source => "puppet:///modules/redshift_config/redshift.conf"
  }

}
