{ pkgs, lib, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./lua/lsp.lua;
      }
      {
        plugin = nvim-navic;
      }
      {
        plugin = nvim-navbuddy;
      }
      {
        plugin = nvim-dap;
        type = "lua";
        config = builtins.readFile ./lua/dap.lua;
      }
      {
        plugin = nvim-dap-virtual-text;
        type = "lua";
        config = "require('nvim-dap-virtual-text').setup()";
      }
      {
        plugin = nvim-dap-ui;
      }
      {
        plugin = nvim-dap-go;
      }
      {
        plugin = pkgs.vimPlugins.neotest;
        type = "lua";
        config = builtins.readFile ./lua/test.lua;
      }
      {
        plugin = neotest-go;
      }
      {
        plugin = neotest-python;
      }
      {
        plugin = neotest-dotnet;
      }
      {
        plugin = nvim-coverage;
        type = "lua";
        config = builtins.readFile ./lua/coverage.lua;
      }
      {
        plugin = trouble-nvim;
        type = "lua";
        config = builtins.readFile ./lua/trouble.lua;
      }
      {
        plugin = omnisharp-extended-lsp-nvim;
      }
      {
        plugin = gp-nvim;
        type = "lua";
        config = builtins.readFile ./lua/gp.lua;
      }
    ];
  };

  home.packages = with pkgs; [
    ansible-language-server
    docker-compose-language-service
    gopls
    helm-ls
    jdt-language-server
    marksman
    nil
    nodejs
    omnisharp-roslyn
    pyright
    rust-analyzer
    solargraph
    sumneko-lua-language-server
    terraform-ls
    vscode-langservers-extracted
  ] ++ (with pkgs.nodePackages; [
      bash-language-server
      dockerfile-language-server-nodejs
      typescript-language-server
      yaml-language-server
  ]);
}
