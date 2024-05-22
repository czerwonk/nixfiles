{ pkgs, lib, config, ... }:

{
  imports = [
    ../common.nix
    ../rofi
    ./theme.nix
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = "disabled";
      favorite-apps = [
        "kitty.desktop"
        "firefox.desktop"
        "thunderbird.desktop"
      ];
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "caffeine@patapon.info"
        "pop-shell@system76.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
      had-bluetooth-devices-setup = true;
      remember-mount-password = false;
    };
    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = false;
      gap-inner = "uint32 1";
      gap-outer = "uint32 1";
      tile-by-default = true;
      smart-gaps = true;
    };
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Super><Shift>S" ];
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      switch-to-application-7 = [];
      switch-to-application-8 = [];
      switch-to-application-9 = [];
      switch-input-source = [];
      switch-input-source-backward = [];
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
    };
    "org/gnome/desktop/session" = {
      idle-delay = "uint32 300";
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 9;
      workspace-names = [
        "Home"
        "Terminal"
        "Web"
        "Mail"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      move-to-workspace-5 = [ "<Shift><Super>5" ];
      move-to-workspace-6 = [ "<Shift><Super>6" ];
      move-to-workspace-7 = [ "<Shift><Super>7" ];
      move-to-workspace-8 = [ "<Shift><Super>8" ];
      move-to-workspace-9 = [ "<Shift><Super>9" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      switch-to-workspace-9 = [ "<Super>9" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      control-center = [ "<Super>comma" ];
      www = [ "<Super>b" ];
      screensaver = [ "<Control><Super>l" ];
      custom-keybindings=[
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "${lib.getExe pkgs.kitty}";
      name = "Open Terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>Space";
      command = "${lib.getExe config.programs.rofi.package} -show drun";
      name = "Open Application Launcher";
    };
    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "kitty.desktop:2"
        "firefox.desktop:3"
        "thunderbird.desktop:4"
        "org.gnome.Fractal.desktop:5"
        "teams-for-linux.desktop:9"
      ];
    };
  };

  services.gpg-agent.pinentryFlavor = "gnome3";
}
