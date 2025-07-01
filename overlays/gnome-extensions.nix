self: super: {
  gnomeExtensions = super.gnomeExtensions // {
    pop-shell = super.gnomeExtensions.pop-shell.overrideAttrs (oldAttrs: {
      preFixup =
        oldAttrs.preFixup
        + ''
          echo '.pop-shell-search-element:select{ color: #DCD7BA !important; }' >> $out/share/gnome-shell/extensions/pop-shell@system76.com/light.css
        '';

      patches = oldAttrs.patches or [ ] ++ [
        ./patches/pop-shell-gnome-48.patch
      ];
    });
  };
}
