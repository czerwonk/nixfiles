{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./persistence.nix
    ../../configuration.nix
    ../../profiles/amd-rocm
    ../../profiles/container
    ../../profiles/desktop
    ../../profiles/desktop/gnome.nix
    ../../profiles/gaming
    ../../profiles/virtualisation
    ../../tpm.nix
    ../../zfs/desktop.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.zfs.requestEncryptionCredentials = [ "zroot" ];

  boot.extraModprobeConfig = ''
    options usbserial vendor=0403 product=6001
  '';

  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "24G";
    cleanOnBoot = false;
  };

  networking = {
    hostName = "hakone";
    hostId = "a7f2e1c4";
    firewall.filterForward = false;
  };

  security.lockKernelModules = false;

  services.fwupd.enable = true;

  services.printing.enable = true;

  services.fprintd.enable = true;

  services.dnsmasq.settings.no-hosts = false;

  powerManagement.cpuFreqGovernor = "ondemand";
  services.power-profiles-daemon.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    package = pkgs.ollama-rocm;
  };
}
