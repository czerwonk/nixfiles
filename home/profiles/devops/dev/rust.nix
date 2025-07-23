{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      cargo
      cargo-audit
      clippy
      pkg-config
      rustc
      rustfmt
      wasm-pack
    ];
    sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };
  };
}
