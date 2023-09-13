{
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ 
      "relatime"
      "size=2G"
      "mode=755"
      "nosuid"
      "nodev"
    ];
  };

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/srv"
      "/home"
      "/var/log"
      "/var/lib"
      "/var/cache"
      "/etc/NetworkManager/"
      "/data"
    ];
    files = [
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
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
