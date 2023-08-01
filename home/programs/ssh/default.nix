{
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    serverAliveInterval = 10;
    extraConfig = ''
      HostKeyAlgorithms=+ssh-rsa
    '';
    matchBlocks = {
      routing-rocks = {
        host = "*.routing.rocks";
        user = "daniel";
        port = 2222;
      };
      ffe_backbone = {
        host = "bb-*.ff-e.net";
        user = "dan_nrw";
        port = 2222;
      };
      ffe = {
        host = "*.freifunk-essen.net *.ff-e.net";
        user = "dan_nrw";
      };
    };
  };
}
