{ lib, config, ... }:

{
  config = lib.mkIf (!config.networking.nftables.enable) {
    boot.kernelmodules = [
      "xt_nat"
      "xt_connmark"
      "xt_mark"
      "xt_comment"
      "xt_limit"
      "xt_addrtype"
      "xt_multiport"
    ];
  };
}
