{ username, pkgs, lib, modulesPath, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../profiles/qemu-vm
    ../../profiles/desktop/core.nix
    ../../profiles/desktop/gnome.nix
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  services.dnsmasq.enable = false;

  services.xserver.displayManager.gdm.wayland = false;
}
