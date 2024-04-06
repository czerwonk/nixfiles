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
        plugin = copilot-lua;
        type = "lua";
        config = ''
          require('copilot').setup {
            copilot_node_command = '${lib.getExe pkgs.nodejs}',
            panel = {
              enabled = false,
            },
            suggestion = {
              enabled = false,
            },
          }
        '';
      }
      {
        plugin = copilot-cmp;
        type = "lua";
        config = ''
          vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
          require("copilot_cmp").setup()
        '';
      }
      {
        plugin = omnisharp-extended-lsp-nvim;
      }
    ];
  };

  home.packages = with pkgs; [
    ansible-language-server
    docker-compose-language-service
    gopls
    helm-ls
    marksman
    nil
    nodejs
    omnisharp-roslyn
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
}
