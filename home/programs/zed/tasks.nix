{ lib, pkgs, ... }:

{
  programs.zed-editor = {
    userTasks = [
      {
        label = "File Finder";
        command = "zeditor \"$(${lib.getExe pkgs.television} files)\"";
        hide = "always";
        allow_concurrent_runs = true;
        use_new_terminal = true;
      }
      {
        label = "Find in Files";
        command = "zeditor \"$(${lib.getExe pkgs.television} text)\"";
        hide = "always";
        allow_concurrent_runs = true;
        use_new_terminal = true;
      }
    ];
  };
}
