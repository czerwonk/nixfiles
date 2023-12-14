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
      docker-compose
      wireshark
      calibre
      remmina
      teamviewer
      mattermost-desktop
      virt-viewer
      yubioath-flutter
      mysql-workbench
    ];
    extraGroups = [ "wireshark" ];
  };

  programs = {
    wireshark.enable = true;
    _1password-gui.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services.pcscd.enable = true;
}
