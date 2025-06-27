{ config, lib, ... }:

{
  imports = [
    ./neovide.nix
    ../agentic-coding
  ];

  programs.neovim.withLLM = true;

  my.scripts.neovimExe = lib.mkDefault "${lib.getExe config.programs.neovim.sandboxPackage}";

  home = {
    shellAliases = {
      nvim = "${lib.getExe config.programs.neovim.sandboxPackage}";
    };
  };
}
