export PATH="$HOME/workspace/infrastructure/homedirs/common/bin:$PATH"

# need this set to xterm-256color to get proper color support in vim
export TERM='xterm-256color'

if [[ -f ~/.zsh/zsh-dircolors-solarized/zsh-dircolors-solarized.zsh ]]; then
  source ~/.zsh/zsh-dircolors-solarized/zsh-dircolors-solarized.zsh
fi

# I want colorized ls by default
alias ls="ls --color=always"

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

# GREP_OPTIONS env variable is deprecated
alias grep='grep --color'
alias op_auth='eval $(op signin my)'
alias start_agent='eval $(ssh-agent -s)'
alias keys="ssh_op_agent load -n machine.summer.gaming -f \"base64 encoded ssh private key\" -p \"ssh key passphrase\" -t 4"
