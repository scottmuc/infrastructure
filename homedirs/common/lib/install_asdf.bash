install_asdf() {
  if command -v asdf >/dev/null; then
    echo "asdf exists: $(asdf --version)"
    return
  fi

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1
}
