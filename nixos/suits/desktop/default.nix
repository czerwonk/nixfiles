{ pkgs, username, ... }:

{
  imports = [
    ./core.nix
    ./pam.nix
    ./gnome.nix
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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.pcscd.enable = true;

  virtualisation.virtualbox.host = {
    enable = true;
  };
}
