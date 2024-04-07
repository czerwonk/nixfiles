{ username, pkgs, lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../profiles/desktop/core.nix
    ../../profiles/desktop/plasma.nix
    ./vbox-fix.nix
  ];

  boot.loader.grub.enable = true;
  boot.initrd.postDeviceCommands = lib.mkBefore ''
    mkdir -p /btrfs_mnt
    mount -o subvol=/ /dev/mapper/enc /btrfs_mnt
    echo "Delete old root subvolume..."
    btrfs subvolume list -o /btrfs_mnt/root |
      cut -f 9 -d ' ' |
      while read subvolume; do
        echo "Delete subvolume $subvolume..."
        btrfs subvolume delete "/btrfs_mnt/$subvolume"
      done
    btrfs subvolume delete /btrfs_mnt/root
    echo "Create new root subvolume..."
    btrfs subvolume create /btrfs_mnt/root
    umount /btrfs_mnt
  '';

  networking.hostId = "f0659bbf";

  users.users.${username} = {
    initialHashedPassword = "$6$rounds=50000$lAvjJYJgE8kUR6We$QKS9zjKcYrFQlz1jFnqkHs9amUeZbjFxZVQVuMbVrpsXMDNnWa1yUq2sU1Hf7yLNsesjeUSojUx0R9MN99nEL0";
    description = lib.mkForce "";
    packages = with pkgs; [
      gnome.gnome-tweaks
      wgnord
      linuxKernel.packages.linux_hardened.virtualboxGuestAdditions
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

  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
  };

  virtualisation.virtualbox.guest.enable = true;

  services.dnsmasq.enable = false;
  services.stubby.enable = false;
}
