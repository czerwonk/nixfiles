{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    dotnet-sdk_8
    omnisharp-roslyn
  ];
}
