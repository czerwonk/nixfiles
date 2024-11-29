{ pkgs, lib, config, extraHomeModules, ... }:

{
  imports = [
    ../../../home/osx
    ../../../home/programs/kitty
    ../../../home/profiles/devops
  ] ++ extraHomeModules;

  programs.zsh.shellAliases = {
    ycode = "${lib.getExe pkgs.yubikey-manager} oath accounts code | ${lib.getExe config.programs.fzf.package}";
  };

  programs.tmux.mouse = true;

  programs.kitty = {
    settings = {
      hide_window_decorations = false;
      background_opacity = "0.9";
    };
  };

  services.gpg-agent.enable = true;
}
