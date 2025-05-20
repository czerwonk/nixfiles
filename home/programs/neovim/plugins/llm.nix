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
            "command": "${lib.getExe pkgs.docker}",
            "args": [
              "run",
              "-i",
              "--rm",
              "mcp/time"
            ],
            "env": {
              "DOCKER_HOST": "unix:///run/user/1000/podman/podman.sock"
            }
          },
          "memory": {
            "command": "${lib.getExe pkgs.docker}",
            "args": [
              "run",
              "-i",
              "--rm",
              "mcp/memory"
            ],
            "env": {
              "DOCKER_HOST": "unix:///run/user/1000/podman/podman.sock"
            }
          }
        }
      }
    '';
  };
}
