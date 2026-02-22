{
  description = "Flake for vagrant based FreeBSD testing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
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
          # Vagrant will connect to system libvirtd socket
          export LIBVIRT_DEFAULT_URI="qemu:///system"

          # Ignores ruby warnings. The ruby wrapped by gems spits out warnings like:
          # Ignoring rbs-3.4.0 because its extensions are not built. Try: gem pristine rbs --version 3.4.0
          export RUBYOPT="-W0"
        '';
      };
    };
}
