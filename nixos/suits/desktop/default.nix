{ pkgs, username, ... }:

{
  imports = [
    ./core.nix
    ./pam.nix
    ./gnome.nix
  ];

  boot.kernelModules = [
    "usbserial"
    "ccm" # required for personal hotspot
    "qrtr"
    "sha3_generic"
    "rfcomm"
    "uhid"
  ];

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

  programs = {
    wireshark.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    hyprland.enable = true;
  };

  services.pcscd.enable = true;

  virtualisation.virtualbox.host = {
    enable = true;
    #enableExtensionPack = true; # TODO: uncomment when build errors are resolved
  };
}
