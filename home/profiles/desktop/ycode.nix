{
  pkgs,
  lib,
  config,
  ...
}:

let
  ycode = pkgs.writeScriptBin "ycode" ''
    ${lib.getExe pkgs.yubikey-manager} $@ oath accounts code | ${lib.getExe config.programs.fzf.package} --tmux
  '';
in
{
  home.packages = [
    ycode
  ];
}
