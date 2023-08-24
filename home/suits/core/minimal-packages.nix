{ pkgs, ... }:

{
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
      yamlfmt
      tree
      exa
      ripgrep
      fd
      sd
      dutree
      screen
      watch
      openssl
      p7zip
      dejavu_fonts
      meslo-lgs-nf
    ];
  };
}
