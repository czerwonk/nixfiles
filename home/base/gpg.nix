{ config, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    settings = {
      auto-key-retrieve = true;
      no-emit-version = true;
      default-key = "B2411B8540A141F90E7EA2D08DA95869D2FFD34C";
    };
  };

  home.file.".gnupg/gpg-agent.conf".text = ''
    default-cache-ttl 7200
    max-cache-ttl 86400
    enable-ssh-support
  '';
}
