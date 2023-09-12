{
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=2G" "mode=755" ];
  };

  environment.persistence."/nix/persist" = {
    directories = [
      "/srv"
      "/home"
      "/var/log"
      "/var/lib"
    ];
    files = [
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/machine-id"
    ];
    enableDebugging = true;
  };
}
