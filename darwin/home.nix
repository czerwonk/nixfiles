{
  imports = [
    ../home/osx
    ../home/profiles/desktop/common.nix
  ];

  my.programs.ghostty = {
    package = null;
    extraConfig = ''
      macos-titlebar-style = hidden
      background-opacity = 0.99
    '';
  };
}
