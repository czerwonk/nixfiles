{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    php83
    php83Packages.composer
    php83Packages.php-cs-fixer
    phpactor
  ];
}
