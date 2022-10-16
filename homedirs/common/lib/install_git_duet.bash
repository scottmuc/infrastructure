
# TODO: extract version string
install_git_duet() {
  curl -L "https://github.com/git-duet/git-duet/releases/download/0.9.0/$(uname)_amd64.tar.gz" 2> /dev/null \
    | tar -zxvf - -C ../../vendor/bin
}
