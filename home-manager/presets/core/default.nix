{ pkgs, ... }:

{
  imports = [
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
      yubikey-manager
    ];
  };

}
