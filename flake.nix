{
  description = "Mucrastructure Dev Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      ciPkgs = [
        pkgs.ansible-lint
        pkgs.flake-checker
        pkgs.nixfmt
        pkgs.opentofu
        pkgs.shellcheck
        pkgs.tflint
      ];

      devPkgs = [
        pkgs.ansible
        pkgs.bash
        pkgs.cachix
        pkgs.git-crypt
        pkgs.skopeo
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
