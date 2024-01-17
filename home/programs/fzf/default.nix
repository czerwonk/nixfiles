{ pkgs, lib, ... }:

{
  programs.fzf = {
    enable = lib.mkDefault true;
    enableZshIntegration = true;
    fileWidgetOptions = [
      "--preview '${pkgs.bat}/bin/bat --color=always --style=numbers --line-range=:500 {}'"
    ];
  };
}
