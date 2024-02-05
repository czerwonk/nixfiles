{ pkgs, lib, username, ... }:

{
  imports = [
    ./core.nix
    ./pam.nix
    ./gnome.nix
    ./impermanence.nix
  ];

  users.users.${username} = {
    packages = with pkgs; [
      appimage-run
      bitwarden
      brave
      calibre
      element-desktop
      fluent-reader
      gimp
      libreoffice
      mysql-workbench
      nextcloud-client
      nix-alien
      remmina
      sublime4
      termius
      thunderbird
      veracrypt
      virt-viewer
      vlc
      wireshark
      xsel
    ];
    extraGroups = [ "wireshark" ];
  };

  services.teamviewer.enable = true;

  programs.wireshark.enable = true;

  programs.nix-index.enable = true;
  programs.command-not-found.enable = false;

  programs.nix-ld.enable = true;

  services.flatpak.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.pcscd.enable = true;

  virtualisation.virtualbox.host = {
    enable = true;
  };

  services.custom.openssh-server.enable = true;
  networking.firewall.extraInputRules = lib.mkAfter ''
    ip6 saddr 2001:678:1e0::/48 tcp dport 2222 accept
  '';
}
