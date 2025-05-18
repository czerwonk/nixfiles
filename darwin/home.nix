{
  imports = [
    ../home/osx
    ../home/programs/ghostty
  ];

  programs.ghostty = {
    settings = {
      window-decoration = true;
      macos-titlebar-style = "hidden";
      background-opacity = 0.99;
    };
  };
}
