{ pkgs, lib, config, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../suits/desktop
    ../../suits/pentest
    ../../suits/container
    ../../suits/virtualisation
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.extraModprobeConfig = ''
    options usbserial vendor=0403 product=6001
  '';
  boot.kernelParams = [ "mem_sleep_default=deep" ];
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_7;

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

  security.lockKernelModules = false;

  services.printing.enable = true;

  services.fprintd.enable = true;

  powerManagement.cpuFreqGovernor = "performance";
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_BAT = 0;

      RUNTIME_PM_ON_BAT = "auto";

      CPU_SCALING_GOVERNOR_ON_AC = "${config.powerManagement.cpuFreqGovernor}";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };
}
