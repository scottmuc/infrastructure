# Adventures in Nix

## Nix Installation

After going down the path of following the official [Nix installer][official-nix-installer] a few times, I'm finally
ready to admit that the [Determinate Systems installer][determinate-installer]. I wanted to understand better why I
**shouldn't** use the official one. I read [their post][determinate-installer-post] and started to get a clearer
picture. Some of the major things I like are:

* The preview of the plan (and with extra details if you ask the installer to explain each step).
* The storage of a `/nix/receipt.json` which I find analogous to a terraform state file.
* A straightforward uninstall process. It's not compicated, but the steps for the
  [official nix uninstall instructions][official-nix-uninstall] definitely deterred me from starting from scratch
  several times.

To keep my Nix experience as vanilla as possible though, I'm not using the `--determinate` flag to the `install` command
of the installer.

[official-nix-installer]: https://nixos.org/download/
[official-nix-uninstall]: https://nix.dev/manual/nix/2.25/installation/uninstall.html
[determinate-installer]: https://github.com/DeterminateSystems/nix-installer
[determinate-installer-post]: https://determinate.systems/posts/determinate-nix-installer/

## Home Manager Installation

I'm still getting up to speed to modern things like `flakes` so I've opted for the
[standalone install][home-manager-install] of Home Manager. When the time comes, I'm sure I'll migrate to using `flakes`
but I'm not there yet.

[home-manager-install]: https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone
