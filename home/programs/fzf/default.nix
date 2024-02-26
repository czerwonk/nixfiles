{ pkgs, lib, ... }:

{
  programs.fzf = {
    enable = lib.mkDefault true;
    enableZshIntegration = true;
    fileWidgetOptions = [
      "--preview '${lib.getExe pkgs.bat} --color=always --style=numbers --line-range=:500 {}'"
    ];
  };
}
