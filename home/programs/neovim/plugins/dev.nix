{ pkgs, lib, util, ... }:

{
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
    ];
  };

  home.packages = with pkgs; [
    alejandra
    ansible-language-server
    gopls
    helm-ls
    jdt-language-server
    marksman
    nil
    prettierd
    pyright
    python312Packages.black
    shfmt
    solargraph
    stylua
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
