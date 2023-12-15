{ username, pkgs, lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../suits/desktop/core.nix
    ../../suits/desktop/gnome.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.persistence."/persist" = {
    directories = [
      "/etc/wireguard"
    ];
  };

  users.users.${username} = {
    initialHashedPassword = "$6$rounds=50000$lAvjJYJgE8kUR6We$QKS9zjKcYrFQlz1jFnqkHs9amUeZbjFxZVQVuMbVrpsXMDNnWa1yUq2sU1Hf7yLNsesjeUSojUx0R9MN99nEL0";
    description = lib.mkForce "";
    packages = with pkgs; [
      gnome.gnome-tweaks
      brave
      wgnord
      linuxKernel.packages.linux_6_5_hardened.virtualboxGuestAdditions
    ];
  };

  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
  };

  virtualisation.virtualbox.guest = {
    enable = true;
    x11 = true;
  };
}
