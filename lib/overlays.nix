{ system, inputs, ... }:

let
  pkgs-legacy = import inputs.nixpkgs-legacy {
    system = system;
    config = { allowunfree = true; };
  };

  pkgs-unstable = import inputs.nixpkgs-unstable {
    system = system;
    config = { allowunfree = true; };
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
