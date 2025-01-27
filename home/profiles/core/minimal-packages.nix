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
      iputils
      jq
      meslo-lgs-nf
      nettools
      openssl
      p7zip
      perlPackages.JSONPP
      ripgrep
      screen
      sd
      sshpass
      watch
      wget
      whois
      yamlfmt
      yq
    ];
  };
}
