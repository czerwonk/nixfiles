{
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/srv"
      "/home"
      "/var/log"
      "/var/lib"
      "/var/cache"
      "/etc/NetworkManager/"
      "/etc/wireguard"
      "/data"
    ];
    files = [
      "/etc/machine-id"
      "/root/.ssh/known_hosts"
    ];
  };
  
  systemd.services.nix-daemon = {
    environment = {
      TMPDIR = "/var/cache/nix";
    };
    serviceConfig = {
      CacheDirectory = "nix";
    };
  };

  environment.variables.NIX_REMOTE = "daemon";
}
