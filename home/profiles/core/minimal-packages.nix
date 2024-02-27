{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      coreutils
      curl
      du-dust
      eza
      fd
      hexyl
      inetutils
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
      yamlfmt
      yq
    ];
  };
}
