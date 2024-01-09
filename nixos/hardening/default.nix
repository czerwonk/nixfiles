{ pkgs, config, lib, ... }:

{
  imports = [
    ./firewall.nix
    ./sysctl.nix
    ./services.nix
    ./aide.nix
    ./accounting.nix
  ];

  users.mutableUsers = false;

  nix.settings.allowed-users = [ "@users" ];
  nix.settings.sandbox = lib.mkDefault false;

  boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_6_6_hardened;

  security.protectKernelImage = true;
  security.forcePageTableIsolation = true;
  security.lockKernelModules = lib.mkDefault true;
  security.sudo.execWheelOnly = true;
  security.allowUserNamespaces = lib.mkDefault false;

  systemd.coredump.enable = lib.mkDefault false;
  security.pam.loginLimits = [
    { domain = "*"; item = "core"; type = "hard"; value = "0"; }
  ];

  security.unprivilegedUsernsClone = config.virtualisation.containers.enable;
  security.virtualisation.flushL1DataCache = "always"; 

  boot.blacklistedKernelModules = [
    "ax25"
    "netrom"
    "rose"
    "dccp"
    "sctp"
    "rds"
    "tipc"

    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "hfs"
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "ntfs"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
    "ufs"
  ];

  security.loginDefs = {
    settings = {
      UMASK = "027";
      ENCRYPT_METHOD = "SHA512";
      SHA_CRYPT_MIN_ROUNDS = "50000";
      SHA_CRYPT_MAX_ROUNDS = "50000";
      PASS_MAX_DAYS = "365";
      PASS_MIN_DAYS = "1";
      PASS_WARN_AGE = "30";
      LOGIN_RETRIES = "3";
      LOGIN_TIMEOUT = "60";
    };
  };

  environment.systemPackages = [
    pkgs.vulnix
  ];
}
