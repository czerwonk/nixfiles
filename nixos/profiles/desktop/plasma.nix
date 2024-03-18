{ inputs, ... }:

{
  disabledModules = [
    "programs/chromium.nix"
    "programs/gnupg.nix"
    "services/x11/desktop-managers/plasma5.nix"
    "services/x11/display-managers/sddm.nix"
  ];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/programs/chromium.nix"
    "${inputs.nixpkgs-unstable}/nixos/modules/programs/gnupg.nix"
    "${inputs.nixpkgs-unstable}/nixos/modules/services/desktop-managers/plasma6.nix"
    "${inputs.nixpkgs-unstable}/nixos/services/x11/display-managers/sddm.nix"
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
}
