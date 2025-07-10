{
  pkgs,
  lib,
  config,
  util,
  ...
}:

with lib;

{
  options = {
    programs.neovim.withCoding = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.programs.neovim.withCoding {
    programs.neovim = {
      extraLuaConfig = lib.mkAfter ''
        ${builtins.readFile ./lua/lsp.lua}
        ${util.readDirString ./lua/lsp}
      '';
      plugins = with pkgs.vimPlugins; [
        {
          plugin = conform-nvim;
          type = "lua";
          config = builtins.readFile ./lua/conform.lua;
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
          plugin = nvim-dap-lldb;
          type = "lua";
          config = ''
            require('dap-lldb').setup {
              codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
            }
          '';
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
          plugin = neotest-rust;
        }
      ];
      extraPackages =
        with pkgs;
        [
          ansible-language-server
          cargo-nextest
          gopls
          helm-ls
          marksman
          nil
          nixfmt-rfc-style
          pyright
          rust-analyzer
          shfmt
          solargraph
          stylua
          sumneko-lua-language-server
          terraform-ls
          typescript-language-server
        ]
        ++ (with pkgs.nodePackages; [
          bash-language-server
          dockerfile-language-server-nodejs
          yaml-language-server
        ]);
    };
  };
}
