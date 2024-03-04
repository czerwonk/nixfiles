{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./lua/lsp.lua;
      }
      {
        plugin = lsp-inlayhints-nvim;
      }
      {
        plugin = nvim-navic;
      }
      {
        plugin = nvim-navbuddy;
      }
      {
        plugin = refactoring-nvim;
        type = "lua";
        config = builtins.readFile ./lua/refactoring.lua; 
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
        plugin = copilot-lua;
        type = "lua";
        config = builtins.readFile ./lua/copilot.lua;
      }
      {
        plugin = copilot-cmp;
      }
    ];
  };
}
