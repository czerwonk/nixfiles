{ pkgs, username, ... }:

{
  imports = [
    ./core.nix
    ./pam.nix
    ./gnome.nix
    ./power.nix
    ./impermanence.nix
  ];

  boot.kernelModules = [
    "usbserial"
    "ccm" # required for personal hotspot
    "qrtr"
    "sha3_generic"
    "rfcomm"
    "uhid"
  ];
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  users.users.${username} = {
    packages = with pkgs; [
      xsel
      brave
      thunderbird
      libreoffice
      termius
      vlc
      wireshark
      calibre
      remmina
      teamviewer
      mattermost-desktop
      virt-viewer
      mysql-workbench
      element-desktop
      bitwarden
      gimp
    ];
    extraGroups = [ "wireshark" ];
  };

  programs.wireshark.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.pcscd.enable = true;

  virtualisation.virtualbox.host = {
    enable = true;
  };
}
