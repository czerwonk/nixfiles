{ pkgs, lib, ... }:

{
  imports = [
    ./plugins
    ./sandbox.nix
  ];

  programs.neovim = {
    enable = lib.mkDefault true;
    defaultEditor = true;
    vimdiffAlias = true;
    package = pkgs.neovim-unwrapped;
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
