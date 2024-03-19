{ lib, ... }:

{
  programs.gpg = {
    enable = lib.mkDefault true;
    settings = {
      auto-key-retrieve = true;
      no-emit-version = true;
    };
  };

  services.gpg-agent = {
    enable = lib.mkDefault false;
    enableScDaemon = true;
    enableSshSupport = true;
    defaultCacheTtl = 7200;
    maxCacheTtl = 86400;
  };
}
