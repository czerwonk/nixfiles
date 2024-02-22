{ pkgs, ... }:

{
  imports = [
    ./minimal-packages.nix
    ../../programs/bat
    ../../programs/fzf
    ../../programs/git
    ../../programs/gpg
    ../../programs/ssh
    ../../programs/tmux
    ../../programs/vim
    ../../programs/zsh
    ../../programs/zoxide
  ];

  home = {
    packages = with pkgs; [
      asciinema
      bitwarden-cli
      octave
      openvpn
      wireguard-tools
    ];
  };
}
