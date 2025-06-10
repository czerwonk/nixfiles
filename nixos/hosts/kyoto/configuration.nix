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
    ../../profiles/pentest
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
    hostName = "kyoto";
    hostId = "7181c80f";
    firewall.filterForward = false;
  };

  security.lockKernelModules = false;

  services.fwupd.enable = true;

  services.printing.enable = true;

  services.fprintd.enable = true;

  services.dnsmasq.settings.no-hosts = false;

  powerManagement.cpuFreqGovernor = "ondemand";
  services.power-profiles-daemon.enable = true;

  my.services.k3s = {
    enable = true;
    autoStart = false;
  };

  my.services.ollama = {
    enable = true;
    hsa_override_gfx_version = "11.0.0";
  };
}
