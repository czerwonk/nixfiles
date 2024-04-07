{ inputs, ... }:

{
  disabledModules = [ "virtualisation/virtualbox-host.nix" ];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/virtualisation/virtualbox-host.nix"
  ];

  virtualisation.virtualbox.host = {
    enable = true;
    enableKvm = false;
    addNetworkInterface = false;
    enableHardening = true;
  };
}
