{
  description = "Mucrastructure Dev Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, self, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [
              "vault"
            ];
        };
      };

      ciPkgs = [
        pkgs.ansible-lint
        pkgs.bashNonInteractive
        pkgs.coreutils # provides ls, env, cat, etc...
        pkgs.flake-checker
        pkgs.nixfmt
        pkgs.opentofu
        pkgs.shellcheck
        pkgs.tflint
      ];

      devPkgs = [
        pkgs.ansible
        pkgs.cachix
        pkgs.git-crypt
        pkgs.skopeo
        pkgs.vault
      ]
      ++ ciPkgs;

    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          packages = devPkgs;
        };
        ci = pkgs.mkShell {
          packages = ciPkgs;
        };
      };

      packages.${system}.ci-image = pkgs.dockerTools.buildLayeredImage {
        name = "infrastructure-ci";
        tag = "latest";
        contents = (
          pkgs.dockerTools.usrBinEnv (
            pkgs.buildEnv {
              name = "ci-env";
              paths = ciPkgs;
            }
          )
        );
      };
    };
}
