{ pkgs, lib, ... }:

# All of the options: https://nix-community.github.io/home-manager/options.xhtml
{
  # TODO: exract the following to a machine specific import.
  home.username = "smootz";
  home.homeDirectory = "/home/smootz";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password-cli"
    "obsidian"
    "vivaldi"
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # Revert back to bash for daily terminal use.
    pkgs.bash

    # Figure out how to allowUnfree for just 1password
    pkgs._1password-cli
    pkgs.autojump
    pkgs.bc
    pkgs.clang
    pkgs.curl
    pkgs.fzf
    pkgs.git-crypt
    pkgs.gnupg
    pkgs.gum
    pkgs.jq
    pkgs.mr
    pkgs.neovim
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.syncthing
    pkgs.tmux
    pkgs.unzip

    # Things used with a GUI
    pkgs.gnome-tweaks
    pkgs.obsidian
    pkgs.vivaldi
    pkgs.wl-clipboard

    # Programming languages that need to be available globally
    pkgs.go
    pkgs.nodejs
    pkgs.python3
    pkgs.ruby

    # Useful for bios inspection
    # https://knowledgebase.frame.work/en_us/how-to-check-the-bios-version-on-windows-linux-bios-ryupu8HT3
    pkgs.dmidecode
    pkgs.lshw

    # Going to continue to use mise for project level dependency management. Not going to
    # impose Nix on anyone at this point.
    pkgs.mise

    # Mods is a TUI for ChatGPT like functionality.
    pkgs.mods

    # The nix LSP, not the Determinate Systems auth helper nor the crypto thingy.
    pkgs.nixd

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Variables defined here will show up in `.nix-profile/etc/profile.d/hm-session-vars.sh`,
  # which is sourced by `~/.profile`.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  # By enabling programs.bash this means home-manager will manage the following files:
  # ~/.profile
  # ~/.bash_profile
  # ~/.bashrc
  #
  # Options at: https://github.com/nix-community/home-manager/blob/master/modules/programs/bash.nix
  programs.bash = {
    enable = true;

    enableCompletion = true;
    shellAliases = {
      # https://github.com/NixOS/nixpkgs/issues/121694#issuecomment-2159420924
      apparmor_nix = "echo 0 | sudo tee /proc/sys/kernel/apparmor_restrict_unprivileged_userns";

      ls = "ls --color=always";
      opauth = "eval $(op signin)";
      keys="ssh-op-agent load -n 20240609.keys -p \"ssh key passphrase\" -t 4";
      vim = "echo woopsy, you probably meant nvim, right?";
    };

    initExtra = ''
    export PATH="$HOME/workspace/infrastructure/homedirs/common/bin:$PATH"
    '';

  };

  # Sources autojump.sh in the .bashrc
  programs.autojump = {
    enable = true;
  };

  # evals mise activate in the .bashrc
  programs.mise = {
    enable = true;
  };
}
