{ pkgs, username, ... }:

{
  imports = [
    ./gnome-core.nix
  ];

  users.users.${username} = {
    packages = with pkgs; [
      gnome.gnome-tweaks
      google-chrome
      brave
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
      teams
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
