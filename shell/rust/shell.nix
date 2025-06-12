{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    cargo
    cargo-nextest
    clippy
    rust-analyzer
    rustc
    rustfmt
  ];
}
