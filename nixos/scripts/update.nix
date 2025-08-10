{
  pkgs,
  lib,
  username,
  configName,
  ...
}:

let
  nixUpdate = pkgs.writeShellScriptBin "nix-update" ''
    # This script is run to update the system.
    # It is used to ensure that the system is up-to-date.
    # It will fetch the latest NixOS configuration and rebuild the system.
    set -e

    print_green() { printf '\033[32m%s\033[0m\n' "$*"; }
    print_cyan() { printf '\033[36m%s\033[0m\n' "$*"; }

    pushd ~/.nixfiles >> /dev/null
    print_cyan "Updating NixOS configuration..."
    ${lib.getExe pkgs.git} pull origin main
    print_cyan "Updating system..."
    sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake .#${configName}
    print_green "System updated successfully."
    popd >> /dev/null
  '';
in
{
  users.users.${username}.packages = [
    nixUpdate
  ];
}
