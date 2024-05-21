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
        "element-desktop.desktop"
      ];
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "pop-shell@system76.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
      had-bluetooth-devices-setup = true;
      remember-mount-password = false;
    };
    "org/gnome/shell/extensions/pop-shell" = {
      activate-launcher = [ "<Super>space" ];
      active-hint = true;
      active-hint-border-radius = "uint32 10";
      gap-inner = "uint32 1";
      gap-outer = "uint32 1";
      tile-by-default = true;
      smart-gaps = true;
    };
    "org/gnome/gnome-session" = {
      auto-save-session = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      workspace-names = [
        "Terminal"
        "Web"
        "Mail"
      ];
    };
  };

  services.gpg-agent.pinentryFlavor = "gnome3";
}
