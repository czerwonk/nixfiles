{ pkgs, ... }:

{
  imports = [
    ./packages.nix
    ../../programs/git
    ../../programs/tmux
    ../../programs/ssh
    ../../programs/gpg
    ../../programs/zsh
    ../../programs/vim
    ../../programs/fzf
    ../../programs/bat
  ];
}
