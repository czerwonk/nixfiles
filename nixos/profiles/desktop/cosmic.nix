{ pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.nixos-cosmic.nixosModules.default
  ];

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  services.xserver = {
    displayManager.gdm.enable = lib.mkForce false;
    desktopManager.gnome.enable = lib.mkForce false;
  };

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
  ];

  services.flatpak.enable = lib.mkForce false;
}
