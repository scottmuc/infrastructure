{
  # https://wiki.nixos.org/wiki/Playwright
  description = "Cucumber-js tests with Playwright";

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
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.nodejs
          pkgs.playwright-driver
        ];

        shellHook = ''
          export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
          export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
        '';
      };

      packages.${system}.ci-image = pkgs.dockerTools.buildLayeredImage {
        name = "navidrome-ci";
        tag = "latest";
        contents = [
          pkgs.dockerTools.caCertificates # installs CAs into expected /etc/ssl/certs
          pkgs.dockerTools.usrBinEnv # provides /usr/bin/env
          pkgs.dockerTools.fakeNss # provides /etc/passwd and /etc/group so that getpwuid() works
          (pkgs.buildEnv {
            name = "ci-env";
            paths = [
              pkgs.bashNonInteractive
              pkgs.coreutils # provides ls, env, cat, etc...
              pkgs.nodejs
              pkgs.playwright-driver
            ];
          })
        ];
        config = {
          Env = [
            "PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}"
            "PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true"
            "NODE_EXTRA_CA_CERTS=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
          ];
        };
      };
    };
}
