# ~/bin is the location of personal scripts I would like available everywhere
export PATH="$HOME/workspace/infrastructure/homedirs/osx-work/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

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
alias vim="echo 'woopsy, you probably meant nvim, right?'"

export GPG_TTY=$(tty)

autoload colors && colors
PROMPT="%{$fg[yellow]%}%~ %{$reset_color%}%\? "

reset_prompt() {
  PROMPT="%{$fg[yellow]%}%~ %{$reset_color%}%\? "
}


if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
fi

if [ -f /usr/local/etc/profile.d/autojump.sh ]; then
  source /usr/local/etc/profile.d/autojump.sh
fi

# Bring in work specific things
if [ -f "${HOME}/workspace/code-snippets/user/smuc/dotfiles/dot.zsh.include" ]; then
  source "${HOME}/workspace/code-snippets/user/smuc/dotfiles/dot.zsh.include"
fi
