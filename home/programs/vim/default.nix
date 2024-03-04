{ pkgs, lib, ... }:

{
  imports = [
    ./plugins
  ];

  programs.neovim = {
    enable = lib.mkDefault true;
    defaultEditor = true;
    vimdiffAlias = true;
    package = pkgs.neovim-unwrapped;
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
