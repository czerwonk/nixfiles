{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      curl
      du-dust
      expect
      eza
      fd
      hexyl
      jq
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
      yq
    ];
  };
}
