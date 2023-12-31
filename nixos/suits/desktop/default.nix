{ pkgs, username, inputs, ... }:

let
  pkgs-legacy = import inputs.nixpkgs-legacy {
    system = "x86_64-linux";
    config = { allowUnfree = true; };
  };

in {
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
      pkgs-legacy.bitwarden
      brave
      calibre
      element-desktop
      gimp
      libreoffice
      mysql-workbench
      nextcloud-client
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

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.pcscd.enable = true;

  services.flatpak.enable = true;

  virtualisation.virtualbox.host = {
    enable = true;
  };
}
