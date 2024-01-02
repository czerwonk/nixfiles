{ system, inputs, ... }:

let
  config = { allowunfree = true; };

  pkgs-legacy = import inputs.nixpkgs-legacy {
    inherit system config;
  };

  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system config;
  };

  nix-alien-packages = inputs.nix-alien.packages.${system};

in {
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  nixpkgs.overlays = [
    (self: super: {
      podman = pkgs-unstable.podman;
      podman-unwrapped = pkgs-unstable.podman-unwrapped;
      vimPlugins = pkgs-unstable.vimPlugins;
      bitwarden = pkgs-legacy.bitwarden;
      nix-alien = nix-alien-packages.nix-alien;
    })
  ];
}
