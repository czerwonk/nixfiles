{ pkgs, ... }:

let
  bitwarden-cli = pkgs.writeShellScriptBin "bitwarden-cli" ''
    exec bw "$@"
  '';
  podman = pkgs.writeShellScriptBin "podman" ''
    exec podman "$@"
  '';

in
{
  nixpkgs.overlays = [
    (self: super: {
      bitwarden-cli = bitwarden-cli;
      podman = podman;
    })
  ];
}
