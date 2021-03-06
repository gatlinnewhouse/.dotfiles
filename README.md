# My .dotfiles

I manage my dotfiles with [`yadm`](https://github.com/TheLocehiliosan/yadm).

My `/etc/` folder is backed up via [`etckeeper`](https://wiki.archlinux.org/index.php/etckeeper) to a private GitLab repo<sup><sup><sup><a href="https://gitlab.com/gatlinnewhouse/etc_backup/tree/master">.</a></sup></sup></sup> (I'd rather not scrub everything for personal data there).

### Screenshots

![](Pictures/screenshot.png)

![](Pictures/busyscreenshot.png)

## Setup

* Application launcher: `rofi`
* Bar: `polybar`
* Compositor: `compton` (not currently using a compositor)
* Display Manager: `autologin and auto startx`
* Icon Theme: [`papirus-icon-theme`](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
* Lock: [`betterlockscreen`](https://github.com/pavanjadhaw/betterlockscreen)
* Shell: `zsh` 
  * With [`zplugin`](https://github.com/zdharma/zplugin) for plugins and themes
* Terminal emulator: `urvxt`, aka [`rxvt-unicode-cvx-patches-wideglyphs`](https://aur.archlinux.org/packages/rxvt-unicode-cvs-patched-wideglyphs/)
* Text editor: [`neovim`](https://github.com/neovim/neovim) (it's not necessarily a gui for vim, just makes vim parallel and fixes the codebase of vim) 
  * With [`vim-plug`](https://github.com/junegunn/vim-plug) for plugins and themes
* GTK Theme: [`materia-theme`](https://github.com/nana-4/Flat-Plat)
* Video player: [`gnome-mpv`](https://github.com/gnome-mpv/gnome-mpv)
* Web browser: `firefox`
* Window manager: [`i3-gaps`](https://github.com/Airblader/i3)

### Recommended Firefox extensions/themes

WIP

### Recommended Chrome extensions, even though I do not use Chrome anymore
I recommend the following extensions for Google Chrome: [HTTPS Everywhere](https://chrome.google.com/webstore/detail/https-everywhere/gcbommkclmclpchllfjekcdonpmejbdp?hl=en), [TrackMeNot](https://chrome.google.com/webstore/detail/trackmenot/cgllkjmdafllcidaehjejjhpfkmanmka?hl=en), [Privacy Badger](https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp?hl=en-US), [AdNauseam](https://adnauseam.io/), [WOT: Web of Trust](https://chrome.google.com/webstore/detail/wot-web-of-trust-website/bhmmomiinigofkjcapegjjndpbikblnp?hl=en), [uBlock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm?hl=en), [The Great Suspender](https://chrome.google.com/webstore/detail/the-great-suspender/klbibkeccnjlkjkiokjodocebajanakg?hl=en) (Save some RAM by suspending pages automatically), and Google's [Bookmark Manager](https://chrome.google.com/webstore/detail/bookmark-manager/gmlllbghnfkpflemihljekbapjopfjik?hl=en).

I use many of these for security and/or privacy purposes however I acknowledge that this is in no way foolproof and any interaction taking place on the internet is subject to a lack of privacy.
