{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      typescript
      prettierd
    ];
  };
}
