
install_alacritty_colorscheme() {
  REPO=https://github.com/eendroroy/alacritty-theme.git
  DEST="$HOME/.eendroroy-colorschemes"
  if [[ ! -d "${DEST}" ]]; then
    git clone $REPO $DEST
  fi
  ln -sfv "$DEST/themes" "$HOME/.config/alacritty/colors"
  pip3 install --user alacritty-colorscheme
}

