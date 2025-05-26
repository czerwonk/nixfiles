{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      curl
      coreutils
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
      watch
      wget
      whois
      yq
    ];
  };
}
