{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

{
  options = {
    programs.neovim.withLLM = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.programs.neovim.withLLM {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        {
          plugin = avante-nvim;
          type = "lua";
          config = builtins.readFile ./lua/avante.lua;
        }
        {
          plugin = dressing-nvim;
        }
        {
          plugin = copilot-vim;
          type = "lua";
          config = builtins.readFile ./lua/copilot.lua;
        }
        {
          plugin = mcphub-nvim;
          type = "lua";
          config = ''
            require('mcphub').setup {
              cmd = "${pkgs.mcp-hub}/bin/mcp-hub",
              auto_toggle_mcp_servers = false
            }
          '';
        }
      ];
    };

    home.file.".config/mcphub/servers.json".text = ''
      {
        "mcpServers": {
          "time": {
            "command": "${lib.getExe pkgs.podman}",
            "args": [
              "run",
              "-i",
              "--rm",
              "mcp/time"
            ]
          },
          "memory": {
            "command": "${lib.getExe pkgs.podman}",
            "args": [
              "run",
              "-i",
              "--rm",
              "mcp/memory"
            ]
          },
          "git": {
            "command": "${lib.getExe pkgs.podman}",
            "args": [
              "run",
              "-i",
              "--rm",
              "mcp/git"
            ]
          }
        }
      }
    '';
  };
}
