
setup_neovim() {
  nvim -c "PlugInstall" -c "qall" --headless
  nvim -c "PlugUpdate" -c "qall" --headless
  nvim -c "UpdateRemotePlugins" -c "qall" --headless
}
