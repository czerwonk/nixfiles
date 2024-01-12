{ pkgs, ... }:

{
  security.wrappers.mtr-packet = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_raw+p";
    source = "${pkgs.mtr}/bin/mtr-packet";
  };
  security.wrappers.ping6 = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_raw+p";
    source = "${pkgs.busybox}/bin/ping6";
  };
}
