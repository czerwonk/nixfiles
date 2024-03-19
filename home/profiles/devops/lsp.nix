{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ansible-language-server
      ansible-lint
      docker-compose-language-service
      gopls
      helm-ls
      marksman
      nil
      pyright
      rust-analyzer
      solargraph
      sumneko-lua-language-server
      terraform-ls
    ] ++ (with pkgs.nodePackages; [
        bash-language-server
        dockerfile-language-server-nodejs
        typescript-language-server
        vscode-json-languageserver
        yaml-language-server
    ]);
  };
}
