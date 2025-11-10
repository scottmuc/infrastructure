{
  description = "Flake for vagrant based FreeBSD testing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-25.05";
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

      gems = pkgs.bundlerEnv {
        name = "test-env";
        ruby = pkgs.ruby_3_3;
        gemdir = ./.;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.bundix
          pkgs.libvirt
          pkgs.qemu
          pkgs.vagrant

          gems
          gems.wrappedRuby
        ];

        shellHook = ''
          export VAGRANT_DEFAULT_PROVIDER=libvirt
          # Vagrant will connect to system libvirtd socket
          export LIBVIRT_DEFAULT_URI="qemu:///system"
        '';
      };
    };
}
