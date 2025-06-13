{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    cargo
    cargo-nextest
    clippy
    openssl
    openssl.dev
    pkg-config
    rust-analyzer
    rustc
    rustfmt
  ];
}
