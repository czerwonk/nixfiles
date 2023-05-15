{ config, pkgs, home-manager, username, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
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
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

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
      sublime4
      teams
      calibre
      remmina
      mattermost-desktop
    ];
    extraGroups = [ "wireshark" ];
  };
  programs.zsh.enable = true;
  programs.wireshark.enable = true;
  programs._1password-gui.enable = true;

  networking.firewall.extraCommands = ''
    iptables -A INPUT -i podman+ -p udp --dport 53 -j ACCEPT
  '';
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
