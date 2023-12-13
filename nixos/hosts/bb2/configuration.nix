{
  imports = [ 
    ../../configuration.nix
    ../../suits/server
    ../../suits/container
    ../../suits/routing
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
