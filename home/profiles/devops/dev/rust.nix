{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      lld_21
      pkg-config
      rustup
      wasm-pack
    ];
  };
}
