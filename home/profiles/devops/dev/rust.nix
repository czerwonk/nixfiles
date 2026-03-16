{ pkgs, config, ... }:

{
  home = {
    sessionPath = [ "${config.home.homeDirectory}/.cargo/bin" ];
    packages = with pkgs; [
      lld_21
      pkg-config
      rustup
      wasm-pack
    ];
  };
}
