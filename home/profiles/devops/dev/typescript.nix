{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      typescript
      prettierd
      eslint
      typescript-language-server
    ];
  };
}
