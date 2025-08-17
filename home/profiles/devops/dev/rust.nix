{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      lld_21
      pkg-config
      rustup
      wasm-pack
    ];
    sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.sqlite.dev}/lib/pkgconfig";
    };
  };
}
