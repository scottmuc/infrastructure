
install_git_duet() {
  local version

  version="${1:-0.9.0}"

  if command -v git-duet &> /dev/null; then
    echo "git-duet exists: $(git-duet --version)"
    return
  fi
  curl -L "https://github.com/git-duet/git-duet/releases/download/${version}/$(uname)_amd64.tar.gz" 2> /dev/null \
    | tar -zxvf - -C ../../vendor/bin
}
