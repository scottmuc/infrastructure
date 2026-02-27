{
  description = "Mucrastructure Dev Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
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
    };
}
