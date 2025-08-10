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

    pushd ~/.nixfiles
    echo "Updating NixOS configuration..."
    ${lib.getExe pkgs.git} pull origin main
    echo "Updating system..."
    sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake .#${configName}
    echo "System updated successfully."
    popd
  '';
in
{
  users.users.${username}.packages = [
    nixUpdate
  ];
}
