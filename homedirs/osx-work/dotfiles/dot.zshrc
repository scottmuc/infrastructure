# ~/bin is the location of personal scripts I would like available everywhere
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# need this set to xterm-256color to get proper color support in vim
export TERM='xterm-256color'

# I want colorized ls by default
export LSCOLORS="GxFxCxDxBxEgEdabagacad"
alias ls='ls -G'

# nvim only
alias vim='nvim'

export GREP_OPTIONS="--color"

# Erase duplicates in history, keep 10k entris, and append to the history file
# rather than overwriting it.
export HISTCONTROL=erasedups
export HISTSIZE=10000

# Added to signal 1password-cli
export XDG_CONFIG_HOME="${HOME}/.config"

export EDITOR="vim -f"

autoload colors && colors
PS1="%{$fg[yellow]%}%~ %{$reset_color%}%\? "


if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
fi

if [ -f /usr/local/etc/profile.d/autojump.sh ]; then
  source /usr/local/etc/profile.d/autojump.sh
fi

if [ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

source ~/workspace/bosh-backup-and-restore-home/include.bash.or.zsh
