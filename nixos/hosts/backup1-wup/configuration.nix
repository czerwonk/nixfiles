{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../zfs
    ../../profiles/server
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.zfs.requestEncryptionCredentials = lib.mkForce [ ];
  boot.zfs.extraPools = [ "zdata" ];

  networking = {
    hostId = "77889806";
    hostName = "backup1";
    domain = "wup.routing.rocks";
  };

  environment.persistence."/persist" = {
    files = [
      "/root/.ssh/id_ed25519"
    ];
  };

  nix.settings.sandbox = false;

  routing-rocks.bird.enable = true;

  services.prometheus.exporters.bird = {
    enable = true;
    user = "bird";
  };

  my.services.openssh-server.openFirewall = false;

  my.zfs-replication.enable = true;
}
