{ pkgs, ... }:

{
  home = {
    packages = [
      pkgs.hakanai-cli
    ];
    sessionVariables = {
      HAKANAI_SERVER = "https://hakanai.link";
    };
    shellAliases = {
      hs = "${pkgs.hakanai-cli}/bin/hakanai send";
      hg = "${pkgs.hakanai-cli}/bin/hakanai get";
    };
  };
}
