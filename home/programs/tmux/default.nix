{ pkgs, lib, ... }:

let
  power-theme = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "power";
    rtpFilePath = "tmux-power.tmux";
    version = "unstable-2023-11-27";
    src = pkgs.fetchFromGitHub {
      owner = "wfxr";
      repo = "tmux-power";
      rev = "1d73c304573b3ae369567d2ef635f0e1c3de7ecc";
      hash = "sha256-HOUnLm2GSvJkCxK9ofM5p2I9xpF6Se44/8a/bkwrnmw=";
    };
  };

in {
  programs.tmux = {
    enable = lib.mkDefault true;
    shortcut = lib.mkDefault "a";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    keyMode = "vi";
    escapeTime = 1;
    baseIndex = 1;
    clock24 = true;
    historyLimit = 10000;
    mouse = true;
    newSession = true;
    plugins = with pkgs.tmuxPlugins;[
      tmux-fzf
      yank
      logging
      vim-tmux-navigator
    ];
    extraConfig = ''
      set -g renumber-windows on
      set-option -g allow-rename off

      bind C-l send-keys 'C-l'
      bind-key -n M-S-Left swap-window -d -t -1
      bind-key -n M-S-Right swap-window -d -t +1

      set-option -g status-position top 
      set-option -g window-style 'fg=default,bg=colour234'
      set-option -g window-active-style 'fg=default,bg=colour234'
      set-option -g pane-border-style 'fg=colour242,bg=colour234'
      set-option -g pane-active-border-style 'fg=colour242,bg=colour234'

      set -g @tmux_power_time_format '%H:%M'
      set -g @tmux_power_theme '#C0A36E'
      run-shell ${power-theme}/share/tmux-plugins/power/tmux-power.tmux
    '';
  };
}
