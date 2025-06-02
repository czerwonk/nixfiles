{ pkgs, ... }:

{
  imports = [
    ./minimal-packages.nix
    ../../programs/bat
    ../../programs/fzf
    ../../programs/git
    ../../programs/gpg
    ../../programs/oh-my-posh
    ../../programs/ssh
    ../../programs/tmux
    ../../programs/neovim
    ../../programs/zoxide
    ../../programs/zsh
  ];

  home.packages = with pkgs; [
    bottom
    nerd-fonts.jetbrains-mono
    wireguard-tools
  ];
}
