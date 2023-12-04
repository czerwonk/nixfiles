{ lib, ... }:

{
  programs.ssh = {
    enable = lib.mkDefault true;
    forwardAgent = true;
    serverAliveInterval = 10;
    extraConfig = ''
      HostKeyAlgorithms=+ssh-rsa
      PubkeyAcceptedAlgorithms=+ssh-rsa
    '';
  };
}
