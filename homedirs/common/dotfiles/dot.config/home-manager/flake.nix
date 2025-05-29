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
      url = github:nix-community/home-manager;
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
    pkgs = import nixpkgs { inherit system; };
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

          programs.home-manager.enable = true;

          # This anonymouse function is assigned to the allowUnfreePredicate
          # and will be called whenever an unfree package is specfied. This
          # allows me to only allow this specific list of unfree software.
          nixpkgs.config.allowUnfreePredicate = pkg:
            builtins.elem (pkgs.lib.getName pkg) [
            "1password-cli"
            "obsidian"
            "vivaldi"
          ];

          home.packages = [
            pkgs.hello
          ];
        }
      ];
    };
  };
}
