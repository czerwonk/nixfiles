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
      inetutils
      jq
      meslo-lgs-nf
      openssl
      p7zip
      ripgrep
      screen
      sd
      watch
      wget
      yamlfmt
      yq
    ];
  };
}
