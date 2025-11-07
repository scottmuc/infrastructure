{
  description = "Flake for vagrant based FreeBSD testing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
              "vagrant"
            ];
        };
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.libvirt
          pkgs.qemu
          pkgs.ruby
          pkgs.vagrant
        ];

        shellHook = ''
          export VAGRANT_DEFAULT_PROVIDER=libvirt
          # Vagrant will connect to system libvirtd socket
          export LIBVIRT_DEFAULT_URI="qemu:///system"
        '';
      };
    };
}
