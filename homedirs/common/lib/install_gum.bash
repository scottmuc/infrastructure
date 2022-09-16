
install_gum() {
  curl -L "https://github.com/charmbracelet/gum/releases/download/v0.6.0/gum_0.6.0_$(uname)_x86_64.tar.gz" 2> /dev/null \
    | tar -zxvf - -C ../../vendor/bin gum
}
