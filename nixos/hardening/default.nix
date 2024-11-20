{ pkgs, config, lib, ... }:

{
  imports = [
    ./audit.nix
    ./firewall.nix
    ./sysctl.nix
    ./services.nix
    ./aide.nix
    ./accounting.nix
  ];

  users.mutableUsers = false;

  nix.settings.allowed-users = [ "@users" ];
  nix.settings.sandbox = lib.mkDefault false;

  boot.kernelPackages = lib.mkOverride 500 pkgs.linuxKernel.kernels.linux_6_11_hardened;

  security.protectKernelImage = true;
  security.forcePageTableIsolation = true;
  security.lockKernelModules = lib.mkDefault true;
  security.allowUserNamespaces = lib.mkDefault false;

  security.sudo = {
    execWheelOnly = true;
    extraConfig = lib.mkBefore ''
      Defaults requiretty,use_pty,env_reset

      Defaults:root !requiretty
    '';
  };

  systemd.coredump.enable = lib.mkDefault false;
  security.pam.loginLimits = [
    { domain = "*"; item = "core"; type = "hard"; value = "0"; }
  ];

  security.unprivilegedUsernsClone = lib.mkDefault config.virtualisation.containers.enable;
  security.virtualisation.flushL1DataCache = "always"; 

  programs.firejail.enable = true;

  boot.kernelParams = [
    # Slab/slub sanity checks, redzoning, and poisoning
    "slub_debug=FZP"

    # Overwrite free'd memory
    "page_poison=1"

    # Enable page allocator randomization
    "page_alloc.shuffle=1"
  ];

  boot.blacklistedKernelModules = [
    "ax25"
    "dccp"
    "netrom"
    "rds"
    "rose"
    "sctp"
    "tipc"

    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "befs"
    "bfs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "f2fs"
    "freevxfs"
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
}
