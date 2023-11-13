{
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    serverAliveInterval = 10;
    extraConfig = ''
      HostKeyAlgorithms=+ssh-rsa
      PubkeyAcceptedAlgorithms=+ssh-rsa
    '';
  };
}
