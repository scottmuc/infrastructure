
install_gum() {
  local version

  version="${1:-0.6.0}"

  if command -v gum &> /dev/null; then
    echo "gum exists: $(gum --version)"
    return
  fi
  curl -L "https://github.com/charmbracelet/gum/releases/download/v${version}/gum_${version}_$(uname)_x86_64.tar.gz" 2> /dev/null \
    | tar -zxvf - -C ../../vendor/bin gum
}
