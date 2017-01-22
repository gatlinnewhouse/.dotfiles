# My dotfiles

I manage my dotfiles with puppet, so they should be easy to install.

### Screenshots

WIP

## Setup

* Application launche: `albert`
* Bar: `polybar`
* Compositor: `compton`
* Icons: [`paper`](https://snwh.org/paper)
* Lock: `i3lock`
* Shell: `fizsh`
* Terminal emulator: `urvxt`
* Text editor: `vim` with `vundle`
* Theme: [`paper`](https://snwh.org/paper)
* Video player: `vlc`
* Web browser: `google-chrome`
* Window manager: `i3-gaps`

### Recommended chrome extensions
I recommend the following extensions for Google Chrome: [HTTPS Everywhere](https://chrome.google.com/webstore/detail/https-everywhere/gcbommkclmclpchllfjekcdonpmejbdp?hl=en), [TrackMeNot](https://chrome.google.com/webstore/detail/trackmenot/cgllkjmdafllcidaehjejjhpfkmanmka?hl=en), [Privacy Badger](https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp?hl=en-US), [AdNauseam](https://adnauseam.io/), [WOT: Web of Trust](https://chrome.google.com/webstore/detail/wot-web-of-trust-website/bhmmomiinigofkjcapegjjndpbikblnp?hl=en), [uBlock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm?hl=en), [The Great Suspender](https://chrome.google.com/webstore/detail/the-great-suspender/klbibkeccnjlkjkiokjodocebajanakg?hl=en) (Save some RAM by suspending pages automatically), and Google's [Bookmark Manager](https://chrome.google.com/webstore/detail/bookmark-manager/gmlllbghnfkpflemihljekbapjopfjik?hl=en).

I use many of these for security and/or privacy purposes however I acknowledge that this is in no way foolproof and any interaction taking place on the internet is subject to a lack of privacy.

## Installation

```
sudo paman -Syu
pacman -S puppet
git clone https://github.com/gatlinnewhouse/dotfiles.git ~/.dotfiles
sudo puppet apply --modulepath=$HOME/.dotfiles/modules ~/.dotfiles/manifests/devmachine-root.pp
puppet apply --modulepath=$HOME/.dotfiles/modules ~/.dotfiles/manifests/devmachine.pp
```
