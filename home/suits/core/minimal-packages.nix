{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      coreutils
      curl
      dejavu_fonts
      du-dust
      eza
      fd
      hexyl
      htop
      inetutils
      jq
      meslo-lgs-nf
      openssl
      p7zip
      ripgrep
      screen
      sd
      tree
      vulnix
      watch
      wget
      yamlfmt
      yq
    ];
  };
}
