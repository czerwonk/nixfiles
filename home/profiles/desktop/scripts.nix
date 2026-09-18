{ pkgs, ... }:

let
  caffeinate = pkgs.writeShellScriptBin "caffeinate" ''
    systemd-run --unit=caffeine --user \
      systemd-inhibit --what=idle:sleep --why="''${1:-caffeinate}" sleep infinity
  '';

  decaffeinate = pkgs.writeShellScriptBin "decaffeinate" ''
    exec systemctl --user stop caffeine
  '';
in
{
  home.packages = [
    caffeinate
    decaffeinate
  ];
}
