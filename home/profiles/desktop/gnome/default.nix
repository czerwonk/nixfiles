{ pkgs, lib, ... }:

with lib.gvariant;

{
  imports = [
    ../common.nix
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
        "just-perfection-desktop@just-perfection"
        "pano@elhan.io"
        "pop-shell@system76.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
      had-bluetooth-devices-setup = true;
      remember-mount-password = false;
    };
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Super><Shift>S" ];
      switch-to-application-1 = mkEmptyArray type.string;
      switch-to-application-2 = mkEmptyArray type.string;
      switch-to-application-3 = mkEmptyArray type.string;
      switch-to-application-4 = mkEmptyArray type.string;
      switch-to-application-5 = mkEmptyArray type.string;
      switch-to-application-6 = mkEmptyArray type.string;
      switch-to-application-7 = mkEmptyArray type.string;
      switch-to-application-8 = mkEmptyArray type.string;
      switch-to-application-9 = mkEmptyArray type.string;
      switch-to-application-10 = mkEmptyArray type.string;
      switch-input-source = mkEmptyArray type.string;
      switch-input-source-backward = mkEmptyArray type.string;
      maximize = mkEmptyArray type.string;
      unmaximize = mkEmptyArray type.string;
    };

    "org/gnome/desktop/default/applications/terminal" = {
      exec = "${lib.getExe pkgs.kitty}";
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
    };
    "org/gnome/desktop/session" = {
      idle-delay = mkInt32 300;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;
      workspace-names = [
        "Home"
        "Terminal"
        "Web"
        "Mail"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      switch-to-workspace-9 = [ "<Super>9" ];
      switch-to-workspace-10 = [ "<Super>0" ];
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      move-to-workspace-5 = [ "<Shift><Super>5" ];
      move-to-workspace-6 = [ "<Shift><Super>6" ];
      move-to-workspace-7 = [ "<Shift><Super>7" ];
      move-to-workspace-8 = [ "<Shift><Super>8" ];
      move-to-workspace-9 = [ "<Shift><Super>9" ];
      move-to-workspace-10 = [ "<Shift><Super>0" ];
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
      binding = "<Super>e";
      command = "${lib.getExe pkgs.gnome.nautilus}";
      name = "Open File Explorer";
    };
    "org/gnome/shell/extensions/pop-shell" = {
      activate-launcher = [ "<Super>space" ];
      active-hint = false;
      gap-inner = mkInt32 1;
      gap-outer = mkInt32 1;
      smart-gaps = true;
      tile-by-default = true;
    };
    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "kitty.desktop:2"
        "firefox.desktop:3"
        "thunderbird.desktop:4"
        "element-desktop.desktop:5"
        "Mattermost.desktop:5"
        "teams-for-linux.desktop:9"
      ];
    };
    "org/gnome/shell/extensions/just-perfection" = {
      notification-banner-position = 2;
      workspace-wrap-around = true;
    };
  };

  services.gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;
}
