{ extraHomeModules, ... }:

{
  imports = [
    ../../home
    ../../home/suits/desktop
    ../../home/suits/linux-utils
  ] ++ extraHomeModules;
}
