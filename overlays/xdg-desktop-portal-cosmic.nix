{ pkgs-unstable, ... }:

final: prev:
let
  persistSortPatch = pkgs-unstable.fetchpatch {
    name = "persist-file-chooser-sort.patch";
    url = "https://github.com/pop-os/xdg-desktop-portal-cosmic/commit/38ddd40b3bcf704bfe8413a268a7150f443c1e36.patch";
    hash = "sha256-CIUYzJw4tcoc0E278eHUSjjxNzB3Fa32aPjLW6QAS88=";
  };
in
{
  xdg-desktop-portal-cosmic = pkgs-unstable.xdg-desktop-portal-cosmic.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ persistSortPatch ];
    cargoDeps = pkgs-unstable.rustPlatform.fetchCargoVendor {
      inherit (old) src;
      patches = [ persistSortPatch ];
      hash = "sha256-HIhdl4X/DX4udEW5iAegbu00Dq3PlCEs5OEjXFHXs/c=";
    };
  });
}
