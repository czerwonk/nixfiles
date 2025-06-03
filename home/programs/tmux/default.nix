{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.programs.tmux;

in
{
  options = {
    programs.tmux.position = mkOption {
      type = types.str;
      default = "top";
    };

    programs.tmux.theme.enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = {
    programs.tmux = {
      enable = lib.mkDefault true;
      shortcut = lib.mkDefault "a";
      shell = lib.getExe pkgs.zsh;
      terminal = "screen-256color";
      keyMode = "vi";
      escapeTime = 1;
      baseIndex = 1;
      clock24 = true;
      historyLimit = 10000;
      mouse = mkDefault false;
      newSession = true;
      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
      ];
      extraConfig = ''
        set -g renumber-windows on
        set-option -g allow-rename off
        set-option -g automatic-rename off

        bind C-l send-keys 'C-l'
        bind-key -n M-S-Left swap-window -d -t -1
        bind-key -n M-S-Right swap-window -d -t +1

        set -s set-clipboard external

        set-option -g status-position ${cfg.position}
        set-option -g window-style 'fg=default,bg=colour234'
        set-option -g window-active-style 'fg=default,bg=colour234'
        set-option -g pane-border-style 'fg=colour242,bg=colour234'
        set-option -g pane-active-border-style 'fg=colour242,bg=colour234'

        set -g bell-action none
        set -g monitor-activity on
        set -g monitor-bell on
        set -g visual-activity off
        set -g visual-bell on
        set -g visual-silence off

        bind m {
          set -w monitor-bell
          set -w monitor-activity
          display 'window mute #{?#{monitor-bell},off,on}'
        }

        ${optionalString (cfg.theme.enable) ''
          set -g @tmux_power_time_format '%H:%M'
          set -g @tmux_power_theme '#C0A36E'
          run-shell ${pkgs.tmuxPlugins.power-theme}/share/tmux-plugins/power/tmux-power.tmux
        ''}
      '';
    };

    programs.fzf = {
      tmux = {
        enableShellIntegration = true;
        shellIntegrationOptions = [ "-p" ];
      };
    };
  };
}
