{ pkgs, ... }:

{
  home = {
    packages = [
      pkgs.hakanai-cli
    ];
    sessionVariables = {
      HAKANAI_SERVER = "https://hakanai.routing.rocks";
    };
    shellAliases = {
      hk = "${pkgs.hakanai-cli}/bin/hakanai";
    };
  };
}
