{
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/home"
      "/var/log"
      "/var/lib"
      "/var/cache"
      "/etc/wireguard"
      "/data"
      "/opt"
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
