{ lib, ... }:

{
  programs.ssh = {
    enable = lib.mkDefault true;
    enableDefaultConfig = false;
    extraConfig = ''
      HostKeyAlgorithms=+ssh-rsa
      PubkeyAcceptedAlgorithms=+ssh-rsa
    '';
    settings = {
      "*" = {
        ServerAliveInterval = 10;
      };
    };
  };
}
