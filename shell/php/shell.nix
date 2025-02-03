{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    php84
    php84Packages.composer
    phpactor
  ];
}
