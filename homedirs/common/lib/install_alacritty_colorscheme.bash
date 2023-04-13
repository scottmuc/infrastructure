
install_alacritty_colorscheme() {
  if command -v alacritty-colorscheme &> /dev/null; then
    echo "alacritty-colorscheme exists: $(alacritty-colorscheme --version)"
    return
  fi
  REPO=https://github.com/eendroroy/alacritty-theme.git
  DEST="${HOME}/.eendroroy-colorschemes"
  if [[ ! -d "${DEST}" ]]; then
    git clone "${REPO}" "${DEST}"
  fi
  ln -sfv "${DEST}/themes" "${HOME}/.config/alacritty/colors"
  (cd ~ && pip3 install --user alacritty-colorscheme)
}

