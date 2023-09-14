{ username, pkgs, lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../suits/desktop/gnome-core.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_hardened.prl-tools
  ];

  users.users.${username} = {
    initialHashedPassword = "$6$rounds=50000$5PoVHv3SBKY6MDq9$GgeWlrTm6iEBXu2mAbgC0JZDGVVEbGbtQjCjisNlj9EXb9nFfUHDLbFMabRDn4JUHK7TiEj.BMqhlYFRrZoW21";
    description = lib.mkForce "";
    packages = with pkgs; [
      gnome.gnome-tweaks
      brave
      wgnord
    ];
  };

  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
  };
}
