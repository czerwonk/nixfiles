{
  imports = [
    ../common.nix
    ./theme.nix
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = "disabled";
      enabled-extensions = [
        "pop-shell@system76.com"
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
