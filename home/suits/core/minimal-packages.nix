{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      curl
      vulnix
      inetutils
      coreutils
      hexyl
      btop
      htop
      wget
      jq
      yq
      yamlfmt
      tree
      eza
      ripgrep
      fd
      sd
      dust
      screen
      watch
      openssl
      p7zip
      dejavu_fonts
      meslo-lgs-nf
    ];
  };
}
