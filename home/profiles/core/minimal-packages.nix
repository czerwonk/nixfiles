{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      coreutils
      curl
      dejavu_fonts
      du-dust
      expect
      eza
      fd
      hexyl
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
      yq
    ];
  };
}
