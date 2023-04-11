{ pkgs, ... }:

{
  imports = [
    ./scripts
    ./presets/network
    ./programs/git
    ./programs/tmux
    ./programs/ssh
    ./programs/gpg
    ./programs/zsh
    ./programs/vim
    ./programs/fzf
    ./programs/bat
  ];
  
  programs.home-manager.enable = true;

  home = {
    packages = with pkgs; [
      curl
      inetutils
      coreutils
      hexyl
      btop
      htop
      wget
      jq
      yq
      tree
      exa
      ripgrep
      fd
      dutree
      screen
      watch
      openssl
      p7zip
      meslo-lgs-nf
      asciinema
      openvpn
      wireguard-tools
      podman
      podman-compose
      docker-compose
      yubikey-manager
    ];
  };

}
