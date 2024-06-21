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
    ../../programs/vim
    ../../programs/zoxide
    ../../programs/zsh
  ];

  home.packages = with pkgs; [
    bitwarden-cli
    octave
    wireguard-tools
  ];
}
