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
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          packages = [
            pkgs.ansible
            pkgs.bash
            pkgs.git-crypt
            pkgs.opentofu
            pkgs.skopeo
          ];
        };
        ci = pkgs.mkShell {
          packages = [
            pkgs.shellcheck
            pkgs.tflint
            pkgs.ansible-lint
            pkgs.flake-checker
          ];
        };
      };
    };
}
