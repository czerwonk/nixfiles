{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      gopls
      pyright
      nil
      ansible-lint
      ansible-language-server
      solargraph
      sumneko-lua-language-server
      marksman
      rust-analyzer
    ] ++ (with pkgs.nodePackages; [
        yaml-language-server
        typescript-language-server
        bash-language-server
        vscode-json-languageserver
    ]);
  };
}
