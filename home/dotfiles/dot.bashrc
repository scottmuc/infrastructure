
export EDITOR="nvim"
export PATH="$HOME/workspace/infrastructure/home/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# https://github.com/NixOS/nixpkgs/issues/121694#issuecomment-2159420924
alias apparmor_nix="echo 0 | sudo tee /proc/sys/kernel/apparmor_restrict_unprivileged_userns"
alias ls="ls --color=always"
alias keys="ssh-pp-agent load -n 20240609.keys -p \"ssh key passphrase\" -t 4"
alias nvimo="NVIM_APPNAME=nvim_old_config nvim"

PS1='\w \$ '

if [[ -f ~/.nix-profile/etc/profile.d/autojump.sh ]]; then
  # shellcheck disable=SC1090
  source ~/.nix-profile/etc/profile.d/autojump.sh
fi

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

if [[ ! "$SSH_AUTH_SOCK" ]] || [[ "$agent_run_state" = 2 ]]; then
  start_ssh_agent
fi

# vim: ft=bash
