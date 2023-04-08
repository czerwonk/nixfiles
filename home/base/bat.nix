{ config, lib, pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "TwoDark";
    };
  };
}
