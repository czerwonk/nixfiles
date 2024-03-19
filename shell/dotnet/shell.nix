{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    mono
    dotnet-sdk_8
    omnisharp-roslyn
  ];
}
