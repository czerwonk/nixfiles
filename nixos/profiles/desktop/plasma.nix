{ inputs, ... }:

{
  disabledModules = [
    "services/x11/desktop-managers/plasma5.nix"
    "programs/chromium.nix"
    "programs/gnupg.nix"
  ];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/desktop-managers/plasma6.nix"
    "${inputs.nixpkgs-unstable}/nixos/modules/programs/chromium.nix"
    "${inputs.nixpkgs-unstable}/nixos/modules/programs/gnupg.nix"
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
