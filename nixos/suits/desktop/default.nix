{ pkgs, username, ... }:

{
  networking.networkmanager = {
    enable = true;
    dns = "none";
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

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
      insync
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
