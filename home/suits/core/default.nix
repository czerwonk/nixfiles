{ pkgs, ... }:

{
  imports = [
    ./minimal-packages.nix
    ../../programs/git
    ../../programs/tmux
    ../../programs/ssh
    ../../programs/gpg
    ../../programs/zsh
    ../../programs/vim
    ../../programs/fzf
    ../../programs/bat
  ];

  home = {
    packages = with pkgs; [
      asciinema
      slides
      octave
      openvpn
      wireguard-tools
      yubikey-manager
      bitwarden-cli
    ];
  };
}
