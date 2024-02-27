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
      perlPackages.JSONPP
      ripgrep
      screen
      sd
      sshpass
      watch
      wget
      yamlfmt
      yq
    ];
  };
}
