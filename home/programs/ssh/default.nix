{ lib, ... }:

{
  programs.ssh = {
    enable = lib.mkDefault true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        Compression = false;
        ServerAliveInterval = 10;
        HostKeyAlgorithms = "+ssh-rsa";
        PubkeyAcceptedAlgorithms = "+ssh-rsa";
      };
    };
  };
}
