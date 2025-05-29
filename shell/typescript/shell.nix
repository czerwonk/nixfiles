{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    deno
    typescript
    typescript-language-server
  ];
}
