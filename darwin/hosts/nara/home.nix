{ pkgs, lib, config, extraHomeModules, ... }:

{
  imports = [
    ../../../home/osx
    ../../../home/programs/kitty
  ] ++ extraHomeModules;

  home.packages = with pkgs; [
    wl-clipboard
  ];

  programs.zsh.shellAliases = {
    ycode = "${lib.getExe pkgs.yubikey-manager} oath accounts code | ${lib.getExe config.programs.fzf.package}";
  };

  programs.tmux.mouse = true;

  programs.kitty = {
    settings = {
      hide_window_decorations = false;
    };
  };

  services.gpg-agent.enable = true;
}
