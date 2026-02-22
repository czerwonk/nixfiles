{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    testdisk # contains photorec
    jdupes
  ];
}
