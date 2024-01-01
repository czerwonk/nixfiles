{ pkgs, ... }:

let
  kanagawa_gtk_theme = (pkgs.callPackage ./../../pkgs/kanagawa-gtk-theme {});

in {
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Kanagawa-Dark-B";
      package = kanagawa_gtk_theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
