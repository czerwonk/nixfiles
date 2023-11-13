{ pkgs, pkgs-unstable, username, ... }:

{
  imports = [
    ./gnome-core.nix
  ];

  boot.kernelModules = [ "usbserial" ];

  users.users.${username} = {
    packages = with pkgs; [
      gnome.gnome-tweaks
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
  programs.wireshark.enable = true;
  programs._1password-gui.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.pcscd.enable = true;
}
