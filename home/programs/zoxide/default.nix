{ lib, ... }:

{
  programs.zoxide = {
    enable = lib.mkDefault true;
    options = [
      "--cmd cd"
    ];
  };
}
