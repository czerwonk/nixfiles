{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      cargo
      cargo-audit
      clippy
      lld_21
      pkg-config
      rustc
      rustfmt
      wasm-pack
    ];
    sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.sqlite.dev}/lib/pkgconfig";
    };
  };
}
