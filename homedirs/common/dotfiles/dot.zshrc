# Going to see if this can become a common .zshrc for all my systems.
# This would entail some conditional checks for which system this is
# exuecute in. This should be able to run on Frodo and in WSL.


export PATH="$HOME/workspace/infrastructure/homedirs/common/bin:$PATH"
export PATH="$HOME/workspace/infrastructure/vendor/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"

# need this set to xterm-256color to get proper color support in vim
export TERM='xterm-256color'

# I want colorized ls by default
alias ls="ls --color=always"

# Explictly use emacs key bindsings (needed in tmux for some reason)
# See: https://askubuntu.com/a/1158506
bindkey -e

# Erase duplicates in history, keep 10k entris, and append to the history file
# rather than overwritingin it.
export HISTCONTROL=erasedups
export HISTSIZE=10000

# Explicitly set XDG_* variables
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# These are honoured by several CLI applications
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export EDITOR="nvim"

# Why not `alias vim=nvim`? Rather that having the redirection, I would rather
# develop the muscle memory to type nvim.
alias vim="echo woopsy, you probably meant nvim, right?"

export GPG_TTY=$(tty)

autoload colors && colors
PS1="%{$fg[yellow]%}%~ %{$reset_color%}%\? "


if [[ -f /usr/share/autojump/autojump.sh ]]; then
  source /usr/share/autojump/autojump.sh
fi

# GREP_OPTIONS env variable is deprecated
alias grep='grep --color'
alias opauth='eval $(op signin)'
alias keys="ssh-op-agent load -n 20240609.keys -p \"ssh key passphrase\" -t 4"

# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases
start_ssh_agent() {
  ( umask 077; ssh-agent > ~/.ssh/agent.env)
    # shellcheck disable=SC1090
  . ~/.ssh/agent.env >| /dev/null
}

load_ssh_agent_env() {
  if [[ -f ~/.ssh/agent.env ]]; then
    # shellcheck disable=SC1090
    . ~/.ssh/agent.env >| /dev/null
  fi
}

load_ssh_agent_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [[ ! "${SSH_AUTH_SOCK}" ]] || [[ "${agent_run_state}" = 2 ]]; then
  start_ssh_agent
fi

if [[ -s ~/.asdf/asdf.sh ]]; then
  # shellcheck disable=SC1090
  . ~/.asdf/asdf.sh
fi

heigh-ho() {
  gum style \
    --foreground 212 --border-foreground 212 --border double \
    --align center --width 50 --margin "1 2" --padding "2 4" \
    "Heigh ho, heigh ho," "it's off to work we go!"

  if op-auth-status; then
    echo "already logged into 1 Password"
  else
    eval "$(op signin)"
  fi

  if ssh-add -l | grep 20240609.keys; then
    echo "ssh 20240609.keys already loaded"
  else
    ssh-op-agent load -n 20240609.keys \
      -p "ssh key passphrase" \
      -t 9
  fi

  op read op://Automation/gpg.scottATscottmuc.com/passphrase \
    | wl-copy --trim-newline

  touch /tmp/gpg_agent_priming
  gpg --sign --local-user "scott@scottmuc.com" /tmp/gpg_agent_priming
  rm /tmp/gpg_agent_priming*

  if [[ -z "${OPENAI_API_KEY}" ]]; then
    OPENAI_API_KEY="$(op read "op://Personal/OpenAI/api key")"
    export OPENAI_API_KEY
  fi
}

# vim: set ft=sh
