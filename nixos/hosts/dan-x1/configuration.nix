{ lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../suits/desktop
    ../../suits/pentest
    ../../suits/container
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.extraModprobeConfig = ''
    options usbserial vendor=0403 product=6001
  '';

  boot.initrd.secrets = {
    "/persist/crypto_keyfile.bin" = null;
  };
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.open-fprintd.enable = true;
  services.python-validity.enable = true;

  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;
}
