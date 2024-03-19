{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    mono
    msbuild
    dotnet-sdk_8
  ];
}
