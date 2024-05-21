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
        "pop-shell@system76.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
      had-bluetooth-devices-setup = true;
      remember-mount-password = false;
    };
    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = true;
      active-hint-border-radius = 10;
      gap-inner = 1;
      gap-outer = 1;
      tile-by-default = true;
      activate-launcher = [ "<Super>space" ];
    };
  };

  services.gpg-agent.pinentryFlavor = "gnome3";
}
