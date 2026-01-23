{
  username,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../profiles/qemu-vm
    ../../profiles/desktop/core.nix
    ../../zfs/desktop.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.zfs.forceImportRoot = true;
  boot.zfs.requestEncryptionCredentials = [ "zroot" ];

  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
  };

  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "8G";
    cleanOnBoot = false;
  };

  networking.hostId = "f0659bbf";

  users.users.${username} = {
    initialHashedPassword = "$6$rounds=50000$lAvjJYJgE8kUR6We$QKS9zjKcYrFQlz1jFnqkHs9amUeZbjFxZVQVuMbVrpsXMDNnWa1yUq2sU1Hf7yLNsesjeUSojUx0R9MN99nEL0";
    description = lib.mkForce "";
    packages = with pkgs; [
      wgnord
    ];
  };

  security.chromiumSuidSandbox.enable = true;

  programs.firejail.wrappedBinaries = {
    brave = {
      executable = "${pkgs.lib.getBin pkgs.brave}/bin/brave";
      desktop = "${pkgs.brave}/share/applications/brave-browser.desktop";
      profile = "${pkgs.firejail}/etc/firejail/brave.profile";
    };
  };

  environment.systemPackages = [
    (
      let
        packages = with pkgs; [
          brave
          firefox
        ];

      in
      pkgs.runCommand "firejail-icons"
        {
          preferLocalBuild = true;
          allowSubstitutes = false;
          meta.priority = -1;
        }
        ''
          mkdir -p "$out/share/icons"
          ${lib.concatLines (
            map (pkg: ''
              tar -C "${pkg}" -c share/icons -h --mode 0755 -f - | tar -C "$out" -xf -
            '') packages
          )}
          find "$out/" -type f -print0 | xargs -0 chmod 0444
          find "$out/" -type d -print0 | xargs -0 chmod 0555
        ''
    )
  ];

  services.dnsmasq.enable = false;

  services.xserver.desktopManager.pantheon.enable = true;
  services.pantheon.apps.enable = false;
}
