{ pkgs, lib, ... }:

let 
  lspConfigs = builtins.readDir ./lua/lsp;
  lspConfigLua = map (name: builtins.readFile (./lua/lsp/${name})) (builtins.attrNames lspConfigs);
  lspConfig = ''
    ${builtins.readFile ./lua/lsp.lua}
    ${lib.concatStringsSep "\n\n" lspConfigLua}
  '';

in {
  programs.neovim = {
    extraLuaConfig = lib.mkAfter lspConfig;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
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
        type = "lua";
        config = "require('dap-go').setup()";
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
        plugin = omnisharp-extended-lsp-nvim;
      }
    ];
  };

  home.packages = with pkgs; [
    ansible-language-server
    gopls
    helm-ls
    jdt-language-server
    marksman
    nil
    nodejs
    pyright
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
