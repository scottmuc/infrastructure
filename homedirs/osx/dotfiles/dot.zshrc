# exports
#   HOMEBREW_CELLAR
#   HOMEBREW_PREFIX
#   HOMEBREW_REPOSITORY
# updates
#   PATH
#   MANPATH
#   INFOPATH
if type -p brew > /dev/null; then
  eval "$(brew shellenv)"
fi

export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/workspace/infrastructure/homedirs/osx/bin:$PATH"
export PATH="$HOME/workspace/infrastructure/homedirs/common/bin:$PATH"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"

# need this set to xterm-256color to get proper color support in vim
export TERM='xterm-256color'

# I want colorized ls by default
export LSCOLORS="GxFxCxDxBxEgEdabagacad"
alias ls='ls -G'

export GREP_OPTIONS="--color"

# Explictly use emacs key bindsings (needed in tmux for some reason)
# See: https://askubuntu.com/a/1158506
bindkey -e

# Erase duplicates in history, keep 10k entris, and append to the history file
# rather than overwriting it.
export HISTCONTROL=erasedups
export HISTSIZE=10000

# Added to signal 1password-cli
export XDG_CONFIG_HOME="${HOME}/.config"

export EDITOR="nvim"

# Why not `alias vim=nvim`? Rather that having the redirection, I would rather
# develop the muscle memory to type nvim.
alias vim="echo woopsy, you probably meant nvim, right?"

export GPG_TTY=$(tty)

autoload colors && colors
PS1="%{$fg[yellow]%}%~ %{$reset_color%}%\? "


if [ -f /usr/local/etc/profile.d/autojump.sh ]; then
  source /usr/local/etc/profile.d/autojump.sh
fi


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


alias day="alacritty-colorscheme -V apply solarized_light.yaml"
alias night="alacritty-colorscheme -V apply solarized_dark.yaml"
