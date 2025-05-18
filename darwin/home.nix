{
  imports = [
    ../home/osx
    ../home/programs/ghostty
  ];

  programs.ghostty = {
    settings = {
      macos-titlebar-style = "hidden";
      background-opacity = 0.99;
    };
  };
}
