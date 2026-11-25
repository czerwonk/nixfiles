{ pkgs, ... }:

{
  imports = [
    ./claude-code.nix
  ];

  home.packages = with pkgs; [
    openspec
  ];
}
