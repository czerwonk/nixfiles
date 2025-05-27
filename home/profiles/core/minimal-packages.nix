{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      coreutils
      curl
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
      watch
      wget
      whois
      yq
    ];
  };
}
