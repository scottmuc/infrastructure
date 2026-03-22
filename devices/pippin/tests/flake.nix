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

      nodeModules = pkgs.buildNpmPackage {
        name = "navidrome-node-modules";
        src = ./.; # must contain package.json and package-lock.json
        npmDepsHash = "sha256-ujJDyUqvHt/4+u5eKvVVT0kyHllyiF3q+q/0qLNSWRA=";
        dontBuild = true; # skip `npm run build`
        installPhase = ''
          mkdir -p $out
          cp -r node_modules $out/node_modules
        '';
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.nodejs
          pkgs.playwright-driver
          nodeModules
        ];

        shellHook = ''
          export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
          export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
          export NODE_PATH=${nodeModules}/node_modules
          export PATH=${nodeModules}/node_modules/.bin:$PATH
          ln -sf ${nodeModules}/node_modules ./node_modules
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
              pkgs.curl
              pkgs.dejavu_fonts
              pkgs.fontconfig
              pkgs.nodejs
              pkgs.playwright-driver
              nodeModules
            ];
          })
        ];
        config = {
          Env = [
            "FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf"
            "NAVIDROME_TEST_ENVIRONMENT=container"
            "NODE_EXTRA_CA_CERTS=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            "NODE_PATH=${nodeModules}/node_modules"
            "PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}"
            "PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true"
          ];
        };
      };
    };
}
