{
  pkgs,
  lib,
  config,
  ...
}:

{
  programs.fzf = {
    enable = lib.mkDefault true;
    enableZshIntegration = lib.mkDefault config.programs.zsh.enable;
    fileWidgetOptions = [
      "--preview '${lib.getExe pkgs.bat} --color=always --style=numbers --line-range=:500 {}'"
    ];
  };
}
