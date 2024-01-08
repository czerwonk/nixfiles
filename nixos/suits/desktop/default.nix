{ pkgs, username, ... }:

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
      gimp
      libreoffice
      mysql-workbench
      nextcloud-client
      nix-alien
      obsidian
      remmina
      teamviewer
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

  programs.wireshark.enable = true;

  programs.nix-index.enable = true;
  programs.command-not-found.enable = false;

  programs.nix-ld.enable = true;

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
}
