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
            vim.g.mcphub_initialized = false

            local function load_mcphub()
              if vim.g.mcphub_initialized then
                return
              end

              require('mcphub').setup {
                cmd = "${pkgs.mcp-hub}/bin/mcp-hub",
                shutdown_delay = 30000,
              }
              vim.g.mcphub_initialized = true
            end

            vim.keymap.set('n', '<Leader>M', function()
              load_mcphub()
              vim.cmd('MCPHub')
            end, { desc = 'MCPHub' })
          '';
        }
        {
          plugin = codecompanion-nvim;
          type = "lua";
          config = builtins.readFile ./lua/codecompanion.lua;
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
          },
          "github": {
            "command": "${lib.getExe pkgs.docker}",
            "args": [
              "run",
              "-i",
              "--rm",
              "--env-file",
              "${config.home.homeDirectory}/.config/mcphub/github.env",
              "ghcr.io/github/github-mcp-server"
            ],
            "env": {
              "DOCKER_HOST": "unix:///run/user/1000/podman/podman.sock"
            }
          },
          "mcp_k8s_go": {
            "command": "${lib.getExe pkgs.docker}",
            "args": [
              "run",
              "-i",
              "-v",
              "${config.home.homeDirectory}/.config/mcphub/kubeconfig:/home/nonroot/.kube/config",
              "--rm",
              "mcpk8s/server:latest"
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
