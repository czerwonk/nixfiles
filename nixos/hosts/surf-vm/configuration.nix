{ username, pkgs, pkgs-unstable, lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../suits/desktop/gnome-core.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.grub.useOSProber = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs-unstable; [
    linuxKernel.packages.linux_hardened.prl-tools
  ];

  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/wireguard"
    ];
  };

  users.users.${username} = {
    initialHashedPassword = "$6$rounds=50000$lAvjJYJgE8kUR6We$QKS9zjKcYrFQlz1jFnqkHs9amUeZbjFxZVQVuMbVrpsXMDNnWa1yUq2sU1Hf7yLNsesjeUSojUx0R9MN99nEL0";
    description = lib.mkForce "";
    packages = with pkgs-unstable; [
      pkgs.gnome.gnome-tweaks
      brave
      wgnord
    ];
  };

  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
  };
}
