{ inputs, ... }:

{
  disabledModules = [ "services/x11/desktop-managers/plasma5.nix" ];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/x11/desktop-managers/plasma6.nix"
  ];

  services.xserver = {
    displayManager = {
      defaultSession = "plasma";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
    desktopManager.plasma6.enable = true;
  };

  programs.dconf.enable = true;
}
