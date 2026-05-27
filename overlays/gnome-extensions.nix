self: super: {
  gnomeExtensions = super.gnomeExtensions // {
    pop-shell = super.gnomeExtensions.pop-shell.overrideAttrs (oldAttrs: {
      version = "1.2.0-unstable-gnome50";
      src = super.fetchFromGitHub {
        owner = "pop-os";
        repo = "shell";
        rev = "7898b65c20735057faf0797f8ed056704ca55f0d";
        hash = "sha256-MmHoOxymo0QSRbRcSbFiv82+QWAwIwXwg/wyGQGVYiI=";
      };
      preFixup = oldAttrs.preFixup + ''
        echo '.pop-shell-search-element:select{ color: #DCD7BA !important; }' >> $out/share/gnome-shell/extensions/pop-shell@system76.com/light.css
      '';
    });
  };
}
