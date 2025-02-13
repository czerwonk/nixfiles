{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.programs.neovim.llm;

in {
  options = {
    programs.neovim.llm.enabled = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enabled {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        {
          plugin = llm-nvim;
          type = "lua";
          config = ''
            require('llm').setup {
              backend = "ollama",
              url = "http://localhost:11434",
              model = "codellama",
              lsp = {
                bin_path = '${lib.getExe pkgs.llm-ls}',
              },
              request_body = {
                options = {
                  temperature = 0.2,
                  top_p = 0.95,
                }
              },
              accept_keymap = '<leader>a',
            }
          '';
        }
      ];
    };
  };
}
