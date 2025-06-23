{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      cargo
      cargo-llvm-cov
      clippy
      pkg-config
      rustc
      rustfmt
    ];
    sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };
  };
}
