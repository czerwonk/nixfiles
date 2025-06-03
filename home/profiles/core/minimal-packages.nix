{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      bottom
      curl
      dejavu_fonts
      du-dust
      expect
      eza
      fd
      hexyl
      jq
      openssl
      p7zip
      perlPackages.JSONPP
      ripgrep
      screen
      sd
      sshpass
      uutils-coreutils-noprefix
      watch
      wget
      whois
      wireguard-tools
      yq
    ];
  };
}
