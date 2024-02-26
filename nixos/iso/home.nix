{ extraHomeModules, ... }:

{
  imports = [
    ../../home
    ../../home/suits/linux-utils
    ../../home/suits/devops/lsp.nix
  ] ++ extraHomeModules;
}
