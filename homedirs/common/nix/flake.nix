{
  # All Flakes have: description, inputs, and outputs attributes
  description = "Home Manager configurations";

  inputs = {
    # As opposed to nix-channels, I can specify an arbitrary number of named
    # nixpkgs references depending on my needs. Unsure if nixos-unstable is
    # the branch I want to follow at the moment.
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Here is how I input my home-manager version and instruct home-manager to
    # use the same nixpkgs input as this flake. I'm unsure if this is a good
    # practice because now I may introduce a combination of home-manager and
    # nixpkgs that's never been tested together.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # The ... is because "self" is also passed in, but I'm choosing to ignore
  # it since the linter complains that it's never referenced.
  # The "let" keyword allows the ability to define variables to be accessed in
  # scope of the expression after the "in" keyword
  outputs = { nixpkgs, home-manager, ... }: let
    system = "x86_64-linux";

    # Imports nixpkgs for the specific system we're trying to configure.
    # nixpkgs at this point is a function, and we need to call it to get
    # the actual nixpkgs attribute set.
    pkgs = import nixpkgs {
      inherit system;

      # This anonymouse function is assigned to the allowUnfreePredicate
      # and will be called whenever an unfree package is specfied. This
      # allows me to only allow this specific list of unfree software.
      config.allowUnfreePredicate = pkg:
        builtins.elem (pkgs.lib.getName pkg) [
            "1password-cli"
            "obsidian"
            "vivaldi"
        ];
    };
  in {
    # The arguments to homeManagerConfiguration are:
    # {
    #   modules ? [ ],
    #   pkgs,
    #   lib ? pkgs.lib,
    #   extraSpecialArgs ? { },
    #   check ? true,
    #   # Deprecated:
    #   configuration ? null,
    # }
    # src: https://github.com/nix-community/home-manager/blob/da282034f4d30e787b8a10722431e8b650a907ef/lib/default.nix#L4-L13
    homeConfigurations.micro = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # This can be a list because one can logically seperate the configuration
      # into different files. I'm not going to take advantage of that yet. I
      # prefer the overly commented monolith.
      modules = [
        # All of the options: https://nix-community.github.io/home-manager/options.xhtml
        {
          # Mandatory configurations to be set
          home.username = "micro";
          home.homeDirectory = "/home/micro";
          home.stateVersion = "25.11";

          # The home.packages option allows you to install Nix packages into your
          # environment.
          home.packages = [
            # Revert back to bash for daily terminal use.
            pkgs.bash
            pkgs.starship

            # Figure out how to allowUnfree for just 1password
            pkgs._1password-cli
            pkgs.autojump
            pkgs.bc
            pkgs.clang
            pkgs.curl
            pkgs.fly
            pkgs.fzf
            pkgs.git-crypt
            pkgs.gnumake
            pkgs.gnupg
            pkgs.gum
            pkgs.jq
            pkgs.mr
            pkgs.neovim
            pkgs.nerd-fonts.jetbrains-mono
            pkgs.ripgrep
            pkgs.shellcheck
            pkgs.tmux
            pkgs.unzip

            # Programming languages that need to be available globally
            pkgs.go
            pkgs.nodejs
            pkgs.ruby

            pkgs.python3
            pkgs.python3Packages.pip
            pkgs.python3Packages.virtualenv

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
              ls = "ls --color=always";
              opauth = "eval $(op signin)";
              keys="ssh-op-agent load -n 20240609.keys -p \"ssh key passphrase\" -t 4";
              vim = "echo woopsy, you probably meant nvim, right?";
            };

            initExtra = ''
            export PATH="$HOME/workspace/infrastructure/homedirs/common/bin:$PATH"

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
            '';

          };

          programs.starship = {
            enable = true;
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
      ];
    };
    homeConfigurations.frodo = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # This can be a list because one can logically seperate the configuration
      # into different files. I'm not going to take advantage of that yet. I
      # prefer the overly commented monolith.
      modules = [
        # All of the options: https://nix-community.github.io/home-manager/options.xhtml
        {
          # Mandatory configurations to be set
          home.username = "frodo";
          home.homeDirectory = "/home/frodo";
          home.stateVersion = "25.11";

          # The home.packages option allows you to install Nix packages into your
          # environment.
          home.packages = [
            # Revert back to bash for daily terminal use.
            pkgs.bash
            pkgs.starship

            pkgs._1password-cli
            pkgs.autojump
            pkgs.bc
            pkgs.clang
            pkgs.curl
            pkgs.fzf
            pkgs.gnumake
            pkgs.gnupg
            pkgs.jq
            pkgs.mr
            pkgs.neovim
            pkgs.nerd-fonts.jetbrains-mono
            pkgs.ripgrep
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
            pkgs.ruby

            pkgs.python3
            pkgs.python3Packages.pip
            pkgs.python3Packages.virtualenv

            # Useful for bios inspection
            # https://knowledgebase.frame.work/en_us/how-to-check-the-bios-version-on-windows-linux-bios-ryupu8HT3
            pkgs.dmidecode
            pkgs.lshw

            # Going to continue to use mise for project level dependency management. Not going to
            # impose Nix on anyone at this point.
            pkgs.mise

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

          programs.starship = {
            enable = true;
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
      ];
    };
  };
}
