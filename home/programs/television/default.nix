{ lib, ... }:

{
  programs.television = {
    enable = lib.mkDefault false;
    enableZshIntegration = true;

    settings = {
      shell_integration.keybindings = {
        smart_autocomplete = "ctrl-t";
        command_history = "ctrl-alt-r"; # moved out of atuin's way
      };
    };
  };
}
