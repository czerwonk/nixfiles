{
  imports = [
    ../common.nix
  ];

  boot.supportedFilesystems = [ "bcachefs" ];
}
