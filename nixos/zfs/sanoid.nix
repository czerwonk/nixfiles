{ lib, ... }:

{
  services.sanoid = {
    enable = lib.mkDefault true;
    templates = {
      default = {
        hourly = lib.mkDefault 24;
        daily = lib.mkDefault 7;
        monthly = lib.mkDefault 1;
        autosnap = lib.mkDefault true;
        autoprune = lib.mkDefault true;
      };
    };
    datasets = {
      "zroot/persist".useTemplate = [ "default" ];
    };
  };
}
