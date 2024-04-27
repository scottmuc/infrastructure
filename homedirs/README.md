# Cross Platform Machine Setup

[macOS][macos], [Windows][windows], [WSL][wsl], all have their own GitHub issue template.

[macos]: https://github.com/scottmuc/infrastructure/blob/main/.github/ISSUE_TEMPLATE/macos-repaving-template.md
[windows]: https://github.com/scottmuc/infrastructure/blob/main/.github/ISSUE_TEMPLATE/windows-repaving-template.md
[wsl]: https://github.com/scottmuc/infrastructure/blob/main/.github/ISSUE_TEMPLATE/wsl-repaving-template.md

## Common

* installs the following fonts
  * JetBrainsMono Nerd Font
  * Inconsolas Nerd Font
  * RobotoMono Nerd Font

Switching fonts involves updating the following files:

```
homedirs/common/dotfiles/dot.config/alacritty/alacritty.yml
homedirs/windows/alacritty.yml
homedirs/windows/vscode/settings.json
```

## macOS

* symlinks a few things to `$HOME`
  * **zsh** configuration
  * **git** configuration
  * extending `PATH` with more fun
  * **neovim** configuration
  * **alacritty** and **tmux** configuration
* makes some osx preference changes:
  * dock
  * clock format
* runs **homebrew** things.
* runs OSX softwareupdates

## Windows

* symlinks a few things to `$HOME`
  * **git** configuration
  * **autohotkey** linked to startup
* runs **boxstarter** things.
  * task bar preferfences
  * removes application cruft
  * configures Windows Explorer
  * uses chocolatey to install applications
  * disables Windows sounds

## WSL

* symlinks a few things to `$HOME`
  * **zsh** configuration
  * **git** configuration
  * extending `PATH` with more fun
  * **neovim** configuration
  * **alacritty** and **tmux** configuration
* installs all applications

## Ubuntu

* symlinks a few things to `$HOME`
  * **zsh** configuration
  * **git** configuration
  * extending `PATH` with more fun
  * **neovim** configuration
  * **alacritty** and **tmux** configuration
* installs all applications

## Inspiration

* https://github.com/rockyluke/osx-cli
