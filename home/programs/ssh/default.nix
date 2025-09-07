{ lib, ... }:

{
  programs.ssh = {
    enable = lib.mkDefault true;
    forwardAgent = true;
    serverAliveInterval = 10;
    enableDefaultConfig = false;
    extraConfig = ''
      HostKeyAlgorithms=+ssh-rsa
      PubkeyAcceptedAlgorithms=+ssh-rsa
    '';
  };
}
