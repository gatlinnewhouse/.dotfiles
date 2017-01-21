$mainUser = "delueze"

$desiredPackages = [ 
  'acpid'
  'acroread'
  'albert'
  'arandr'
  'brother-mfc-j410w'
  'cairo-infinality'
  'compton'
  'cups'
  'dolphin-emu'
  'ffmpeg'
  'file-roller'
  'fizsh-git'
  'font-awesome'
  'font-mathematica'
  'godot'
  'google-chrome'
  'google-musicmanager'
  'gpmdp'
  'gscreenshort'
  'htop'
  'i3-gaps'
  'i3lock'
  'i7z'
  'imagemagick'
  'insync'
  'keybase'
  'less'
  'lollypop'
  'lxappearence'
  'minecraft'
  'neofetch'
  'paper-gtk-theme-git'
  'paper-icon-theme-git'
  'pcsx2'
  'polybar'
  'powertop'
  'pulseaudio'
  'puppet'
  'rxvt-unicode'
  'slack-desktop'
  'soulseekqt'
  'steam'
  'sudo'
  'thermald'
  'tlp'
  'tomate-alarm-plugin'
  'tomate-gtk'
  'trash-cli'
  'ttf-google-fonts-git'
  'unclutter-xfixes-git'
  'urxvt-perls'
  'vim'
  'vlc'
  'whatsie'
  'xbanish'
  'xbindkeys'
  'yaourt'
  'youtube-dl'
]

$undesiredPackages = []

package { $desiredPackages:
  ensure => installed
}

package { $undesiredPackages:
  ensure => purged
}
