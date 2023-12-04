{ lib, ... }:

{
  programs.bat = {
    enable = lib.mkDefault true;
    config = {
      pager = "less -FR";
      theme = "TwoDark";
    };
  };
}
