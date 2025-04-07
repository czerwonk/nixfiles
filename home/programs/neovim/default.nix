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
    extraLuaConfig = ''
      ${lib.readFile ./lua/options.lua}
      ${lib.readFile ./lua/keymap.lua}
      ${lib.readFile ./lua/diagnostic.lua}
      ${lib.readFile ./lua/editorfile.lua}
      ${lib.readFile ./lua/abbreviations.lua}
      ${lib.readFile ./lua/marks.lua}
    '';
  };
}
