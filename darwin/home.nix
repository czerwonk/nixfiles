{
  imports = [
    ../home/osx
    ../home/programs/ghostty
  ];

  my.programs.ghostty = {
    package = null;
    extraConfig = ''
      macos-titlebar-style = hidden
      background-opacity = 0.99
    '';
  };
}
