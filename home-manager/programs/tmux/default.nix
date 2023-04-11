{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    keyMode = "vi";
    escapeTime = 1;
    baseIndex = 1;
    clock24 = true;
    historyLimit = 10000;
    mouse = true;
    plugins = with pkgs.tmuxPlugins;[
      tmux-fzf
      yank
      logging
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = power-theme;
        extraConfig = ''
          set -g @tmux_power_theme 'default'
        '';
      }
    ];
    extraConfig = ''
      set -g renumber-windows on
      set-option -g allow-rename off

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      set-option -g status-position top 
    '';
  };
}
