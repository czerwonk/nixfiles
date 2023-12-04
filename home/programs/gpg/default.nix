{ lib, ... }:

{
  programs.gpg = {
    enable = lib.mkDefault true;
    settings = {
      auto-key-retrieve = true;
      no-emit-version = true;
    };
  };

  home.file.".gnupg/gpg-agent.conf".text = ''
    default-cache-ttl 7200
    max-cache-ttl 86400
    enable-ssh-support
  '';
}
