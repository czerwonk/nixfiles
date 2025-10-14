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
    ../../profiles/android
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

  networking.nat.enable = true;

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

  # services.ollama = {
  #   enable = true;
  #   package = pkgs.ollama-rocm;
  #   acceleration = "rocm";
  #   rocmOverrideGfx = "11.0.0";
  #   environmentVariables = {
  #     OLLAMA_FLASH_ATTENTION = "true";
  #     OLLAMA_KV_CACHE_TYPE = "q8_0";
  #     OLLAMA_DEBUG = "0";
  #   };
  # };
}
