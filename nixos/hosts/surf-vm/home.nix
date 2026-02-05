{ username, extraHomeModules, ... }:

{
  imports = [
    ../../../home/profiles/core
    ../../../home/profiles/desktop/librewolf.nix
  ]
  ++ extraHomeModules;

  programs.ghostty.enable = true;
  programs.zed-editor.enable = true;

  programs.git.enable = false;
  programs.gpg.enable = false;
  programs.oh-my-posh.enable = false;
  programs.ssh.enable = false;
  programs.tmux.enable = false;
  programs.zoxide.enable = false;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
