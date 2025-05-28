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
  outputs = { nixpkgs, home-manager, ... }:
     {
      # Use the rec keyword so I can reference pkgs in the home.packages section
      homeConfigurations.frodo = home-manager.lib.homeManagerConfiguration rec {
        # Imports nixpkgs for the specific system we're trying to configure
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [
          {
            # Mandatory configurations to be set
            home.username = "frodo";
            home.homeDirectory = "/home/frodo";
            home.stateVersion = "25.11";

            programs.home-manager.enable = true;

            home.packages = [
              pkgs.hello
            ];
          }
        ];
      };
    };
}
