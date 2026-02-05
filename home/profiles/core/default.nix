{
  imports = [
    ./minimal-packages.nix
    ../../programs
  ];

  programs.hakanai-cli.enable = true;
}
