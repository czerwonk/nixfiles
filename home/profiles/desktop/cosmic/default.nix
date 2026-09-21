{ pkgs, ... }:

{
  imports = [
    ../common.nix
    ./comp.nix
    ./default-applications.nix
    ./panel.nix
    ./shortcuts.nix
    ./theme.nix
  ];

  services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;
}
